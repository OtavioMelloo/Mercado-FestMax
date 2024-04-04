document.getElementById("menu_hamb").addEventListener("click", function () {
  let menuHamburguer = document.querySelector(".menu_hamburguer");
  let menuEscuro = document.querySelector(".menu_escuro");

  // Força o navegador a recalcular as alterações de estilo antes de adicionar a classe 'active'
  menuHamburguer.offsetHeight;

  menuHamburguer.classList.toggle("active"); // Adiciona ou remove a classe 'active' do menu hambúrguer
  menuEscuro.classList.toggle("escuro_active"); // Adiciona ou remove a classe 'active' do menu hambúrguer
});

document.getElementById("fechar_menu").addEventListener("click", function () {
  let menuHamburguer = document.querySelector(".menu_hamburguer");
  let menuEscuro = document.querySelector(".menu_escuro");

  // Força o navegador a recalcular as alterações de estilo antes de remover a classe 'active'
  menuHamburguer.offsetHeight;

  menuHamburguer.classList.remove("active"); // Remove a classe 'active' do menu hambúrguer
  menuEscuro.classList.remove("escuro_active"); // Remove a classe
});
