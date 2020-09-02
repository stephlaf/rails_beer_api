const hideFooterFromHomePage = () => {
  const linksFooter = document.getElementById('links-footer');
  const url = window.location.href;
  const homePages = ["http://localhost:3000/", "https://hopscan.herokuapp.com/"];

  if (homePages.includes(url)) {
    linksFooter.innerHTML = '';
    // linksFooter.hidden = true;
  }
};

export { hideFooterFromHomePage };
