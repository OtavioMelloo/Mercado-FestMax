function calcularTotal() {
    const quantidade = document.querySelector('#quantidade input').value;
    const preco = document.querySelector('#preco p').textContent;
    const total = quantidade * preco;
    document.querySelector('#total p').textContent = `R$ ${total.toFixed(2)}`;
  }
  
  calcularTotal();
  
  document.querySelector('#quantidade input').addEventListener('change', calcularTotal);
  