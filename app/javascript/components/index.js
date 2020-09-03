import { hideFooterFromHomePage } from './footer_links';
import { submitSearchFormAjax, setUrlInHTTPSearchForm, formSubmitListener, turbolinksStuff } from './search_form';

document.addEventListener('turbolinks:load', () => {
  hideFooterFromHomePage();
  submitSearchFormAjax();
});
