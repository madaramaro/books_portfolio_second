document.addEventListener("DOMContentLoaded", (event) => {
  let isProcessed = false; // フラグを追加

  if (document.querySelector('#scanner')) {
    Quagga.init({
      inputStream : {
        name : "Live",
        type : "LiveStream",
        target: document.querySelector('#scanner') // Pointing to video output
      },
      decoder: {
        readers : [ "ean_reader"]
      }
    }, function(err) {
        if (err) {
            console.log(err);
            return;
        }
        console.log("Initialization finished. Ready to start");
        Quagga.start();
    });

    Quagga.onDetected(function(result) {
      console.log("Detection function entered"); // Debugging line
      console.log("Current isProcessed value: ", isProcessed); // Debugging line
    
      try {
        // すでにバーコードが処理されていたら、以降のコードをスキップ
        if (isProcessed) return;
    
        const isbn = result.codeResult.code;
        console.log("Barcode detected and processed : [" + isbn + "]", result);
          
        const hiddenField = document.getElementById('isbn_hidden_field');
        console.log("Before setting ISBN: ", hiddenField.value);
        
        hiddenField.value = isbn;
        
        console.log("After setting ISBN: ", hiddenField.value);
    
        // フラグを更新
        isProcessed = true;
    
        // Quaggaの検出を停止
        Quagga.stop();
        console.log("Quagga stopped.");
        
        // フォームを自動的に送信する
        document.getElementById('search_online_form').submit();
      } catch (error) {
        console.error('Error during detection:', error);
      }
    });
    
  }
});
