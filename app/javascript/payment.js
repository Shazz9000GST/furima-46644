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

    try {
      const response = await payjp.createToken(numberElement);

      if (!response.error) {
        const tokenInput = document.createElement("input");
        tokenInput.type = "hidden";
        tokenInput.name = "token";
        tokenInput.value = response.id;
        form.appendChild(tokenInput);
      }

      form.submit();
    } catch (error) {
      form.submit();
    }
  });
});