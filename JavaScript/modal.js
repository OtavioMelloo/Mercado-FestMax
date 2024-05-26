document.addEventListener('DOMContentLoaded', function() {
    const filialPopup = document.getElementById('filialPopup');

    if (!localStorage.getItem('filialEscolhida')) {
        filialPopup.style.display = 'block';
    }

    window.escolherFilial = function(filial) {
        localStorage.setItem('filialEscolhida', filial);
        filialPopup.style.display = 'none';
        if (filial === 'curitiba') {
            window.location.href = '/curitiba.html';
        } else if (filial === 'bc') {
            window.location.href = '/bc.html';
        }
    };
});
