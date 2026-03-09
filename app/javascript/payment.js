const setupPayment = () => {
  const form = document.getElementById("charge-form");
  if (!form) return;

  if (form.dataset.paymentInitialized === "true") return;
  form.dataset.paymentInitialized = "true";

  const publicKey = form.dataset.payjpPublicKey;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const numberElement = elements.create("cardNumber");
  const expiryElement = elements.create("cardExpiry");
  const cvcElement = elements.create("cardCvc");

  numberElement.mount("#number-form");
  expiryElement.mount("#expiry-form");
  cvcElement.mount("#cvc-form");

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    const existingToken = form.querySelector('input[name="token"]');
    if (existingToken) {
      existingToken.remove();
    }

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
};

document.addEventListener("turbo:load", setupPayment);
document.addEventListener("turbo:render", setupPayment);