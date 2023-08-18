document.addEventListener('DOMContentLoaded', function () {
  const selectElem = document.getElementById('favorite_list_select');
  const detailsDiv = document.getElementById('favorite_list_details');

  if (selectElem) {
    selectElem.addEventListener('change', function () {
      const selectedValue = selectElem.value;

      if (selectedValue !== '') {
        // Railsエンドポイントに非同期リクエストを行う
        fetch(`/favorite_lists/${selectedValue}.json`)
          .then((response) => response.json())
          .then((data) => {
            let detailsHtml = `<h1>${data.name}</h1><ul>`;

            data.books.forEach((book) => {
              detailsHtml += `<li>${book.title}</li>`;
            });

            detailsHtml += `</ul>`;
            detailsDiv.innerHTML = detailsHtml;
          });
      } else {
        detailsDiv.innerHTML = ''; // 選択が解除された場合は詳細をクリア
      }
    });
  }
});
