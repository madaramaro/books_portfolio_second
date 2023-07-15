// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "quagga"

document.addEventListener("DOMContentLoaded", (event) => {
    if (document.querySelector('#scanner')) {
      Quagga.init({
        inputStream : {
          name : "Live",
          type : "LiveStream",
          target: document.querySelector('#scanner') // Pointing to video output
        },
        decoder: {
          readers : [ "code_128_reader"]
        }
      }, function(err) {
          if (err) {
              console.log(err);
              return
          }
          console.log("Initialization finished. Ready to start");
          Quagga.start();
      });
  
      Quagga.onDetected(function(result) {
        console.log("Barcode detected and processed : [" + result.codeResult.code + "]", result);
      });
    }
  });