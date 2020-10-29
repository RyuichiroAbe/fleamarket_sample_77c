window.addEventListener('DOMContentLoaded', function(){
  let path = location.pathname  
  if (path == "/cards/new"){
    let submit = document.getElementById("payment_card_submit-button");

    Payjp.setPublicKey('pk_test_a978463e41581cafd365ad1a');

      submit.addEventListener('click', function(e){

      e.preventDefault();

      let card = {
          number: document.getElementById("payment_card_no").value,
          cvc: document.getElementById("payment_card_cvc").value,
          exp_month: document.getElementById("payment_card_month").value,
          exp_year: document.getElementById("payment_card_year").value
      };

      Payjp.createToken(card, function(status, response) {
        if (status === 200) {
          $(".number").removeAttr("name");
          $(".cvc").removeAttr("name");
          $(".exp_month").removeAttr("name");
          $(".exp_year").removeAttr("name"); 
          $("#charge-form").append(
            $('<input type="hidden" name="payjp_token">').val(response.id)
          );
          document.inputForm.submit();
          alert("登録が完了しました");
        } else {
          alert("カード情報が正しくありません。");
        }
      });
    });
  };
});