import { hideFooterFromHomePage } from './footer_links';
import { submitSearchFormAjax, setUrlInHTTPSearchForm } from './search_form';

document.addEventListener('turbolinks:load', () => {
  hideFooterFromHomePage();
  submitSearchFormAjax();
  setUrlInHTTPSearchForm();
});
