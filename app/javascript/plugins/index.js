import { initQuagga } from './init_quagga';
import { initializeZxing } from './init_zxing';
import { scanditTest } from './init_scandit';

// initQuagga();
// initializeZxing();
document.addEventListener('turbolinks:load', () => {
  scanditTest();
});
