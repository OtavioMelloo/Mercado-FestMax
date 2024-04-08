const valorProduto = 23.90; // Valor do produto pré-definido

function calcularValorTotal() {
  const quantidade = parseInt(document.getElementById("quantidade").value);
  const valorTotal = valorProduto * quantidade;
  document.getElementById("valor-total").value = valorTotal.toFixed(2);
}

// Calcular valor total na inicialização
calcularValorTotal();
