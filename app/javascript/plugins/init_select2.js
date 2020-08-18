import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.select2').select2({
    width: '30%',
    placeholder: "How many ⭐️?",
  });
};

export { initSelect2 };
