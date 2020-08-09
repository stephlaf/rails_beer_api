import * as ScanditSDK from "scandit-sdk";

const key = '';
const results = document.getElementById('results');

const displayData = (data) => {
  console.log(data);
  const beer = `<div>
    <li>Name: ${data.name}</li>
    <li>Short desc: ${data.short_desc}</li>
    <li>Long desc: ${data.long_desc}</li>
    <li>Alcool %: ${data.alc_percent}</li>
    <li>UPC: ${data.upc}</li>
    <img src=${data.image_link} height='120' />
  </div>`;
  results.insertAdjacentHTML('afterbegin', beer);
};

const displayNewBeerForm = (data) => {
  console.log(data);
};

const callController = (scanResult) => {
  const code = scanResult.barcodes[0].data;

  const csrfToken = document.querySelector("[name='csrf-token']").content;

  fetch('http://localhost:3000/beers/get_barcode',{
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': csrfToken
    },
    credentials: 'same-origin',
    body: JSON.stringify({ upc: code })
  })
    .then(response => response.json())
    // .then(displayData)
    
    .then((data) => {
      if (data.id) {
        displayData(data);
      } else {
        displayNewBeerForm(data);
      }
    });
};

const scanditTest = () => {
  ScanditSDK.configure(key, {
    engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk/build",
  })

    .then(() => {
      
      ScanditSDK.BarcodePicker.create(document.getElementById("scandit-barcode-picker"), {
        playSoundOnScan: true,
        // vibrateOnScan: true,
      })

      .then(function (barcodePicker) {
      
        var scanSettings = new ScanditSDK.ScanSettings({
          enabledSymbologies: ["ean8", "ean13", "upca", "upce", "code128", "code39", "code93", "itf"],
          codeDuplicateFilter: 1000
        });

        barcodePicker.applyScanSettings(scanSettings);

        barcodePicker.on("scan", function (scanResult) {
          callController(scanResult);
          barcodePicker.destroy();
        })

        // alert(
        //   scanResult.barcodes.reduce(function (string, barcode) {
        //     return string + ScanditSDK.Barcode.Symbology.toHumanizedName(barcode.symbology) + ": " + barcode.data + "\n";
        //   }, "")
        // );

      })
    });

};

export { scanditTest };

