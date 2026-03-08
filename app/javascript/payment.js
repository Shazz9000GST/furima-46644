document.addEventListener('turbo:load', () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  const publicKey = form.dataset.payjpPublicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const { token, error } = await payjp.createToken(numberElement);

    if (error) {
      alert(error.message);
      return;
    }

    const tokenInput = document.createElement("input");
    tokenInput.setAttribute("type", "hidden");
    tokenInput.setAttribute("name", "token");
    tokenInput.setAttribute("value", token.id);
    form.appendChild(tokenInput);

    form.submit();
  });
});