// import * as Quagga from 'quagga';

// // document.addEventListener("DOMContentLoaded", (event) => {
//   function loadFunction() {
//   let isProcessed = false; // フラグを追加

//   if (document.querySelector('#scanner')) {
//     Quagga.init({
//       inputStream : {
//         name : "Live",
//         type : "LiveStream",
//         target: document.querySelector('#scanner') // Pointing to video output
//       },
//       decoder: {
//         readers : [ "ean_reader"]
//       }
//     }, function(err) {
//         if (err) {
//             console.log(err);
//             return;
//         }
//         console.log("Initialization finished. Ready to start");
//         Quagga.start();
//     });

//     Quagga.onDetected(function(result) {
//       console.log("Detection function entered"); // Debugging line
//       console.log("Current isProcessed value: ", isProcessed); // Debugging line

//       try {
//         // すでにバーコードが処理されていたら、以降のコードをスキップ
//         if (isProcessed) return;

//         const isbn = result.codeResult.code;
//         console.log("Barcode detected and processed : [" + isbn + "]", result);

//         const hiddenField = document.getElementById('isbn_hidden_field');
//         console.log("Before setting ISBN: ", hiddenField.value);

//         hiddenField.value = isbn;

//         console.log("After setting ISBN: ", hiddenField.value);

//         // フラグを更新
//         isProcessed = true;

//         // Quaggaの検出を停止
//         Quagga.stop();
//         console.log("Quagga stopped.");

//         // フォームを自動的に送信する
//         document.getElementById('search_online_form').submit();
//       } catch (error) {
//         console.error('Error during detection:', error);
//       }
//     });

//   }
// });
// // 新たに追加
// document.addEventListener("turbo:load", loadFunction);

document.addEventListener('DOMContentLoaded', function () {
  const selectElement = document.getElementById('favorite_list_select');
  const detailsDiv = document.getElementById('favorite_list_details');

  selectElement.addEventListener('change', function () {
    const selectedListId = selectElement.value;

    if (selectedListId) {
      fetch(`/favorite_lists/${selectedListId}.json`)
        .then((response) => response.json())
        .then((data) => {
          let htmlContent = `
            <h2>${data.name}</h2>
            <ul>
          `;

          data.books.forEach((book) => {
            htmlContent += `
              <li>
                <div>
                  <p>
                    ${
                      book.image_url
                        ? `<img src="${book.image_url}" alt="${book.title}" class='book-image'>`
                        : ''
                    }
                    <strong>Title:</strong>
                    ${book.title}
                  </p>

                  <p>
                    <strong>Author:</strong>
                    ${book.author}
                  </p>

                  <p>
                    <strong>Description:</strong>
                    ${book.description}
                  </p>

                  <p>
                    <strong>Recommended:</strong>
                    ${book.recommended}
                  </p>

                  <p>
                    <strong>Publisher:</strong>
                    ${book.publisher}
                  </p>

                  <p>
                    <strong>Published date:</strong>
                    ${book.published_date}
                  </p>
                </div>
              </li>
            `;
          });

          htmlContent += '</ul>';
          detailsDiv.innerHTML = htmlContent;
        });
    } else {
      detailsDiv.innerHTML = '';
    }
  });
});
