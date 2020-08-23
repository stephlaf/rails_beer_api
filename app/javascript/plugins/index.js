import { initQuagga } from './init_quagga';
import { initializeZxing } from './init_zxing';
import { scanditTest } from './init_scandit';
import { initSelect2, initSelect2Brew } from './init_select2';
import { sortStuff } from './init_match_sorter';

// initQuagga();
// initializeZxing();
document.addEventListener('turbolinks:load', () => {
  scanditTest();
  initSelect2();
  initSelect2Brew();
  sortStuff();
});
