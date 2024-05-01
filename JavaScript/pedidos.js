const priceElement = document.getElementById("price");
var priceText = priceElement.innerText.replace(",",".");
const price = parseFloat(priceText);

const qtdElement = document.getElementById("qtd");
const qtdText = qtdElement.textContent;
const qtd = parseInt(qtdText);

const totalElement = document.getElementById("total");

const result = qtd*price;
totalElement.textContent = result;
