import { hideFooterFromHomePage } from './footer_links';

document.addEventListener('turbolinks:load', () => {
  hideFooterFromHomePage();
});
