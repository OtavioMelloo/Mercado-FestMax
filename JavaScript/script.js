var promos = ["/Assets/IMG/promo1.jpg", "/Assets/IMG/promo2.jpg"];
var promoAtual = 0;

function mudarPromo(direction) {
    promoAtual += direction;
    if (promoAtual < 0) promoAtual = promos.length - 1;
    if (promoAtual >= promos.length) promoAtual = 0;
    document.querySelector("#promo").src = promos[promoAtual];
}
