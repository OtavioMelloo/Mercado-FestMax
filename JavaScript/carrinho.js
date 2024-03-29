function calcularTotal() {
    // Obter o valor da quantidade
    const quantidade = document.getElementById("quantidade").value;

    // Obter o valor do preço unitário
    const precoUnitario = document.getElementById("precoUnitario").value;

    // Calcular o valor total
    const valorTotal = quantidade * precoUnitario;

    // Exibir o valor total
    document.getElementById("valorTotal").innerHTML = valorTotal;
}

const diminuirBtn = document.getElementById("diminuir");
const aumentarBtn = document.getElementById("aumentar");
const numeroInput = document.getElementById("numero");

// Função para diminuir o número
diminuirBtn.addEventListener("click", () => {
    let numeroAtual = parseInt(numeroInput.value);
    if (numeroAtual > 1) {
        numeroAtual--;
        numeroInput.value = numeroAtual;
    }
});

// Função para aumentar o número
aumentarBtn.addEventListener("click", () => {
    let numeroAtual = parseInt(numeroInput.value);
    numeroAtual++;
    numeroInput.value = numeroAtual;
});