import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  const url = window.location.href
  const newBeerRegex = /beers\/new/
  const newBeerTabRegex = /beer_tabs\/new/

  $('.select2').select2({
    width: '100%',
    templateSelection: function () {
        if (newBeerRegex.test(url)) { // adjust for custom placeholder values
          return 'Brewery name?';
        } else if (newBeerTabRegex.test(url)) {
          return 'How many ⭐️?';
        }
      }
  });
};

export { initSelect2 };
