$(document).on('turbolinks:load', function () {
  // 本を追加するフォームのサブミットイベント
  document
    .querySelector('#add-book-form')
    .addEventListener('ajax:success', function (event) {
      const [data, , xhr] = event.detail;
      // 例: 新しい本のHTMLを追加するロジック
    });

  // 本を削除するリンクのクリックイベント
  document.querySelectorAll('.remove-book-link').forEach((link) => {
    link.addEventListener('ajax:success', function (event) {
      // 例: 本のDOM要素を削除するロジック
      event.target.closest('.book-div').remove();
    });
  });
});
