import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const url = window.location.href
  const newBeerRegex = /beers\/new/
  const newBeerTabRegex = /beer_tabs\/new/
  const editBeerTabRegex = /beer_tabs\/\d+\/edit/

  $('.select2').select2({
    width: '50%',
    placeholder: "Combien d'⭐️ ?",
    // templateSelection: function () {
    //     if (newBeerRegex.test(url)) { // adjust for custom placeholder values
    //       return 'Brewery name?';
    //     } else if (newBeerTabRegex.test(url) || editBeerTabRegex.test(url)) {
    //       return 'How many ⭐️?';
    //     }
    //   // return data.text;
    //   },
    // selectOnClose: true
  });
};

const initSelect2Brew = () => {
  const url = window.location.href
  const newBeerRegex = /beers\/new/
  const newBeerTabRegex = /beer_tabs\/new/
  const editBeerTabRegex = /beer_tabs\/\d+\/edit/

  $('.select2-breweries').select2({
    width: '100%',
    placeholder: 'Brasserie ?',
  });
};

export { initSelect2, initSelect2Brew };
