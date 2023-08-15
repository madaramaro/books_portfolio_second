document.addEventListener('DOMContentLoaded', function () {
  const selectElem = document.getElementById('favorite_list_select');
  const detailsDiv = document.getElementById('favorite_list_details'); // 詳細を表示するdivを追加

  if (selectElem) {
    selectElem.addEventListener('change', function () {
      const selectedValue = selectElem.value;

      if (selectedValue !== '') {
        // Railsエンドポイントに非同期リクエストを行う
        fetch(`/favorite_lists/${selectedValue}.json`)
          .then((response) => response.json())
          .then((data) => {
            // JSONデータを使用して詳細を表示
            detailsDiv.innerHTML = `
              <h2>${data.name}</h2>
              // ここにさらなる詳細を追加します...
            `;
          });
      } else {
        detailsDiv.innerHTML = ''; // 選択が解除された場合は詳細をクリア
      }
    });
  }
});
