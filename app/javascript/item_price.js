document.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);
    const taxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (!Number.isInteger(price) || price < 300 || price > 9999999) {
      taxDom.textContent = "-";
      profitDom.textContent = "-";
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = Math.floor(price - tax);

    taxDom.textContent = tax;
    profitDom.textContent = profit;
  });
});