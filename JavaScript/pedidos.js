function calculateTotal() {
  var priceInput = document.getElementById("price1");
  var quantityInput = document.getElementById("quantity1");
  var totalPriceSpan = document.getElementById("total1");

  var price = parseFloat(priceInput.value);
  var quantity = parseInt(quantityInput.value);
  var total = price * quantity;

  totalPriceSpan.textContent = total.toFixed(2); // Format to two decimal places
}