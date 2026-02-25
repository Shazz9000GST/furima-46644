document.addEventListener("turbo:load", setupItemPrice);
document.addEventListener("turbo:render", setupItemPrice);

function setupItemPrice() {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  // 二重登録防止（turbo:load / turbo:render の両方で呼ばれる可能性があるため）
  if (priceInput.dataset.priceListenerAdded === "true") return;
  priceInput.dataset.priceListenerAdded = "true";

  const taxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  // 要素が無い場合は何もしない（念のため）
  if (!taxDom || !profitDom) return;

  // 初期表示（入力済みで戻ってきた時にも反映）
  updateTaxProfit(priceInput.value, taxDom, profitDom);

  priceInput.addEventListener("input", () => {
    updateTaxProfit(priceInput.value, taxDom, profitDom);
  });
}

function updateTaxProfit(rawValue, taxDom, profitDom) {
  const price = Number(rawValue);

  // 数値として不正 or 範囲外なら "-"
  if (!Number.isInteger(price) || price < 300 || price > 9999999) {
    taxDom.textContent = "-";
    profitDom.textContent = "-";
    return;
  }

  const tax = Math.floor(price * 0.1);
  const profit = Math.floor(price - tax);

  taxDom.textContent = String(tax);
  profitDom.textContent = String(profit);
}