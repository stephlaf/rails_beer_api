import { BrowserQRCodeReader } from '@zxing/library';

const initializeZxing = async () => {
  // const codeReader = new BrowserQRCodeReader();
  // const img = document.getElementById('barcode-scanner');
  // const result = await codeReader.decodeFromImage(img);

  // const firstDeviceId = videoInputDevices[0].deviceId;

  const codeReader = new BrowserQRCodeReader();

  codeReader
    .listVideoInputDevices()
    .then(videoInputDevices => {
      codeReader
        .decodeOnceFromVideoDevice(undefined, 'video')
        .then(result => console.log(result.text))
        .catch(err => console.error(err));

    })



  // codeReader
  //   .decodeOnceFromVideoDevice(firstDeviceId, 'video')
  //   .then(result => console.log(result.text))
  //   .catch(err => console.error(err));

  // try {
  // } catch (err) {
  //     console.error(err);
  // }

};

export { initializeZxing };
