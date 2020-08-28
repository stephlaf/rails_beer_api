const submitSearchFormAjax = () => {
  const searchForm = document.getElementById('ajax-search-form');

  if (searchForm) {
    const searchField = document.getElementById('ajax-search-field');
    const allBeerCards = document.querySelectorAll('.beer-card');
    const resultsCounter = document.getElementById('results-count');
    
    searchForm.addEventListener('submit', (event) => {
      event.preventDefault();

      fetch(`http://localhost:3000/api/v1/beers/search?query=${searchField.value}`)
        .then(response => response.json())
        .then((arrayData) => {
          const idArray = Array.from(arrayData);
          const ids = idArray.map(obj => obj.id);
          resultsCounter.innerText = `${ids.length} ${ids.length === 1 ? 'Résultat' : 'Résultats'}`;

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
