import * as ScanditSDK from "scandit-sdk";

const results = document.getElementById('results');

// const displayData = (data) => {
//   console.log(data);

//   const beer = `<div>
//     <li>Name: ${data.name}</li>
//     <li>Short desc: ${data.short_desc}</li>
//     <li>Long desc: ${data.long_desc}</li>
//     <li>Alcool %: ${data.alc_percent}</li>
//     <li>UPC: ${data.upc}</li>
//     <li></li>
//   </div>`;
//   results.insertAdjacentHTML('afterbegin', beer);
// };

// const displayNewBeerForm = (data) => {
//   console.log(data);
// };

const callController = (scanResult) => {
  const code = scanResult.barcodes[0].data;

  const csrfToken = document.querySelector("[name='csrf-token']").content;
    if (Window.location === 'http://localhost:3000/') {
      const url = 'http://localhost:3000/beers/get_barcode';
    } else if (Window.location === 'https://hopscan.herokuapp.com/') {
      const url = 'https://hopscan.herokuapp.com/beers/get_barcode';
    }
  // fetch('http://localhost:3000/beers/get_barcode',{
  fetch(url,{
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
    .then((data) => {
      if (data.id) {
        // displayData(data);
        window.location.assign(`https://hopscan.herokuapp.com/beers/${data.id}`)
        // window.location.assign(`http://localhost:3000/beers/${data.id}`)
      } else {
        // displayNewBeerForm(data);
        window.location.assign(`https://hopscan.herokuapp.com/beers/new/${data.upc}`)
      }
    });
};

const scanditTest = () => {
  const barcodeElement = document.getElementById("scandit-barcode-picker");
  // console.log(barcodeElement.dataset.scanditkey);

  if (barcodeElement) {
    ScanditSDK.configure(barcodeElement.dataset.scanditkey, {
      engineLocation: "https://cdn.jsdelivr.net/npm/scandit-sdk/build",
    })

      .then(() => {
        
        // ScanditSDK.BarcodePicker.create(barcodeElement), {
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
  // if closing
  }

};

export { scanditTest };

