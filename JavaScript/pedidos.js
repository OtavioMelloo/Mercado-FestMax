const priceElement = document.getElementById("price");
var priceText = priceElement.textContent;
priceText = priceText.replace(",",".");
const price = parseInt(priceText);

const qtdElement = document.getElementById("qtd");
const qtdText = qtdElement.textContent;
const qtd = parseInt(qtdText);

const totalElement = document.getElementById("total");

const result = qtd*price;
totalElement.textContent = result;

console.log(qtd);
console.log(price);
console.log(totalElement);