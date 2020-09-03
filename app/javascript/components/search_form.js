const submitSearchFormAjax = () => {
  const searchForm = document.getElementById('remote-search-form');

  searchForm.addEventListener('ajax:beforeSend', (event) => {
    const detail = event.detail,
            xhr = detail[0],
        options = detail[1];

    Turbolinks.visit(options.url);
    event.preventDefault();
  });
};

export { submitSearchFormAjax };
