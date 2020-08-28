import { hideFooterFromHomePage } from './footer_links';
import { submitSearchFormAjax } from './search_form';

document.addEventListener('turbolinks:load', () => {
  hideFooterFromHomePage();
  submitSearchFormAjax();
});
