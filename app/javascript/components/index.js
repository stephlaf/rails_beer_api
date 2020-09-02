import { hideFooterFromHomePage } from './footer_links';
import { submitSearchFormAjax, setUrlInHTTPSearchForm, formSubmitListener } from './search_form';

document.addEventListener('turbolinks:load', () => {
  hideFooterFromHomePage();
  // submitSearchFormAjax();
  setUrlInHTTPSearchForm();
  formSubmitListener();
});
