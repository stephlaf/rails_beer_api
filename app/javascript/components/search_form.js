const setUrlInHTTPSearchForm = () => {
  const hiddenUrlField = document.getElementById('currentUrl');
  if (hiddenUrlField) {
    hiddenUrlField.value = window.location.href;
  }
};

const validatePreviousURL = (url) => {
  // console.log(url);
  let result;
  if (url !== '') {
    // Request coming from a page other than /beers
    result = false;
  } else {
    // Request coming from /beers
    result = true;
  }
  return result;
};

const getUrl = () => {
  const url = window.location.href;
  const baseUrl = url.split(window.location.pathname)[0];
  const fetchUrl = `${baseUrl}/api/v1/beers/search?query=`;

  // const url = window.location.href;

  // const localhostRegex = /localhost/;
  // const herokuRegex = /hopscan/;
  // let fetchUrl;

  // if (localhostRegex.test(url)) {
  //   fetchUrl = 'http://localhost:3000/api/v1/beers/search?query=';
  // } else if (herokuRegex.test(url)) {
  //   fetchUrl = 'https://hopscan.herokuapp.com/api/v1/beers/search?query=';
  // }
  return fetchUrl;
};


const submitSearchFormAjax = (searchField) => {
  const allBeerCards = document.querySelectorAll('.beer-card');
  const resultsCounter = document.getElementById('results-count');
  const fetchUrl = getUrl();

    fetch(`${fetchUrl}${searchField.value}`)
      .then(response => response.json())
      .then((arrayData) => {
        // console.log('from ajax search:', arrayData);
        const idArray = Array.from(arrayData);
        const ids = idArray.map(obj => obj.id);
        resultsCounter.innerText = `${ids.length} ${ids.length === 1 ? 'Résultat' : 'Résultats'}`;

        // console.log(allBeerCards);

        allBeerCards.forEach((beerCard) => {
          beerCard.hidden = false;
          if (ids.includes(Number.parseInt(beerCard.dataset.id, 10))) {
            beerCard.hidden = false;
          } else {
            beerCard.hidden = true;
          }
        });
      });
};

const validateRequestOrigin = () => {
  const searchForm = document.getElementById('ajax-search-form');

  if (searchForm) {
    const searchField = document.getElementById('ajax-search-field');

    const allBeerCards = document.querySelectorAll('.beer-card');
    const resultsCounter = document.getElementById('results-count');
    const fetchUrl = getUrl();
    
    searchForm.addEventListener('submit', (event) => {
      event.preventDefault();

      const fromBeersIndexPage = validatePreviousURL(searchField.dataset.url);
      
      if (!fromBeersIndexPage) {
        searchField.dataset.url = '';
        const url = window.location.href;
        const host = url.split('/beers')[0];
        loadAllBeerCards(`${host}/api/v1/beers/load`);
      }

      fetch(`${fetchUrl}${searchField.value}`)
        .then(response => response.json())
        .then((arrayData) => {
          const idArray = Array.from(arrayData);
          const ids = idArray.map(obj => obj.id);
          resultsCounter.innerText = `${ids.length} ${ids.length === 1 ? 'Résultat' : 'Résultats'}`;

          allBeerCards.forEach((beerCard) => {
            beerCard.hidden = false;
            if (ids.includes(Number.parseInt(beerCard.dataset.id, 10))) {
              beerCard.hidden = false;
            } else {
              beerCard.hidden = true;
            }
          });
        });
    });
  }
};






const insertBeerInHTML = (beer) => {
  const allBeersContainer = document.getElementById('all-beers-container');
  allBeersContainer.insertAdjacentHTML('beforeend', beer);
};

const loadAllBeerCards = (loadUrl) => {
  return new Promise((resolve, reject) => {
    fetch(loadUrl)
      .then(response => response.json())
      .then((beersDivs) => {
        beersDivs.results.forEach((beerDiv) => {
          insertBeerInHTML(beerDiv);
        });
        // return 'proutprout';
        return 'proutprout';
      });
    });
};

const formSubmitListener = () => {
  const searchForm = document.getElementById('ajax-search-form');

  if (searchForm) {
    const searchField = document.getElementById('ajax-search-field');

    searchForm.addEventListener('submit', async (event) => {
      event.preventDefault();
      const fromBeersIndexPage = validatePreviousURL(searchField.dataset.url);
      
      if (!fromBeersIndexPage) {
        searchField.dataset.url = '';

        const url = window.location.href;
        const host = url.split('/beers')[0];

        const loaded = await loadAllBeerCards(`${host}/api/v1/beers/load`);
        loaded.then(x =>  console.log(x));
        console.log(loaded);
        await submitSearchFormAjax(searchField);

      } else {
        console.log('fromBeersIndexPage');
      }
    });
  }
};

export { submitSearchFormAjax, setUrlInHTTPSearchForm, formSubmitListener };
