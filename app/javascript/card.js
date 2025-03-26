const pay = () => {
  const publicKey = gon.public_key; // 公開鍵を取得
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  // カード情報入力フィールドの生成
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // フォームの指定HTML要素に入力欄をマウント
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォーム送信キャンセル

    // トークン生成
    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
   
      } else {
        const token = response.id;
        const hiddenTokenField = document.createElement('input');
        hiddenTokenField.setAttribute('type', 'hidden');
        hiddenTokenField.setAttribute('name', 'token');
        hiddenTokenField.setAttribute('value', token);

        form.appendChild(hiddenTokenField);

        // カード情報をクリア（安全性のため）
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
      }
      form.submit(); // トークンを含めてフォーム送信
    });
  });
};

// Turboのrender時にも発火させるためのイベントリスナーを追加
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);