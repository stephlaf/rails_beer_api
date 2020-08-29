const getUrl = () => {
  const url = window.location.href;
  const localhostRegex = /localhost/;
  const herokuRegex = /hopscan/;
  let fetchUrl;

  if (localhostRegex.test(url)) {
    fetchUrl = 'http://localhost:3000/api/v1/beers/search?query=';
  } else if (herokuRegex.test(url)) {
    fetchUrl = 'https://hopscan.herokuapp.com/api/v1/beers/search?query=';
  }
  return fetchUrl;
};

const submitSearchFormAjax = () => {
  const searchForm = document.getElementById('ajax-search-form');

  if (searchForm) {
    const searchField = document.getElementById('ajax-search-field');
    const allBeerCards = document.querySelectorAll('.beer-card');
    const resultsCounter = document.getElementById('results-count');
    const fetchUrl = getUrl();
    
    searchForm.addEventListener('submit', (event) => {
      event.preventDefault();

      fetch(`${fetchUrl}${searchField.value}`)
        .then(response => response.json())
        .then((arrayData) => {
          const idArray = Array.from(arrayData);
          const ids = idArray.map(obj => obj.id);
          resultsCounter.innerText = `${ids.length} ${ids.length === 1 ? 'Résultat' : 'Résultats'}`;

// console.log(allBeerCards);

          allBeerCards.forEach((beerCard) => {
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

export { submitSearchFormAjax };
