var promos = ["/Assets/IMG/promo1.png", "/Assets/IMG/promo2.png"];
var promoAtual = 0;

function mudarPromo(direction) {
    promoAtual += direction;
    if (promoAtual < 0) promoAtual = promos.length - 1;
    if (promoAtual >= promos.length) promoAtual = 0;
    document.querySelector("#promo").
    src = promos[promoAtual];
}

const dots = document.querySelectorAll(".dot");
const setaDireita = document.getElementById("seta-direita");
const setaEsquerda = document.getElementById("seta-esquerda");

let currentDotIndex = 0;

setaDireita.addEventListener("click", () => {
    dots[currentDotIndex].classList.remove("active");
    currentDotIndex = (currentDotIndex + 1) % dots.length;
    dots[currentDotIndex].classList.add("active");
});

setaEsquerda.addEventListener("click", () => {
    dots[currentDotIndex].classList.remove("active");
    currentDotIndex = (currentDotIndex - 1 + dots.length) % dots.length;
    dots[currentDotIndex].classList.add("active");
});

// Seta direita no último dot
dots[dots.length - 1].addEventListener("click", () => {
    dots[currentDotIndex].classList.remove("active");
    currentDotIndex = 0;
    dots[currentDotIndex].classList.add("active");
});

// Seta esquerda no primeiro dot
dots[0].addEventListener("click", () => {
    dots[currentDotIndex].classList.remove("active");
    currentDotIndex = dots.length - 1;
    dots[currentDotIndex].classList.add("active");
});