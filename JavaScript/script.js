var promos = ["/Assets/IMG/promo1.jpg", "/Assets/IMG/promo2.jpg"];
var currentPromo = 0;

function mudarPromo(direction) {
    currentPromo += direction;
    if (currentPromo < 0) currentPromo = promos.length - 1;
    if (currentPromo >= promos.length) currentPromo = 0;
    document.querySelector("#promo").src = promos[currentPromo];
}
