// ページが読み込まれた際にイベントを設定
const calculatePrice = () => {
  // 必要な要素を取得
  const priceInput = document.getElementById("item-price");
  const taxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  // 要素が存在する場合のみイベントを設定
  if (priceInput) {
    priceInput.addEventListener("input", () => {
      // 入力された値を取得
      const inputValue = parseInt(priceInput.value, 10);

      if (!isNaN(inputValue) && inputValue >= 300 && inputValue <= 9999999) {
        // 販売手数料(10%)と販売利益を計算
        const tax = Math.floor(inputValue * 0.1); // 手数料を計算（小数点以下切り捨て）
        const profit = inputValue - tax;          // 利益を計算（小数点以下切り捨て）

        // 結果をブラウザに描画
        taxDom.innerHTML = tax.toLocaleString();  // 手数料を表示
        profitDom.innerHTML = profit.toLocaleString(); // 利益を表示
      } else {
        // 入力が範囲外の場合は0を表示
        taxDom.innerHTML = "0";
        profitDom.innerHTML = "0";
      }
    });
  }
};

// Turboイベントに対応
window.addEventListener("turbo:load", calculatePrice);
window.addEventListener("turbo:render", calculatePrice);
