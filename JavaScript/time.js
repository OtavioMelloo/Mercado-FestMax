document.addEventListener("DOMContentLoaded", function() {
    filter_elements("todos");
});

function filter_elements(categoria) {
    const buttons = document.querySelectorAll(".btn");

    buttons.forEach((button) => {
        button.classList.remove("selected");
        if (button.textContent === categoria) {
            button.classList.add("selected");
        }
    });

    const elements = document.querySelectorAll(".filtro");
    elements.forEach((element) => {
        element.classList.remove("show");
        if (categoria === "todos" || element.classList.contains(categoria)) {
            element.classList.add("show");
        }
    });

    const setoresFiltro = document.querySelector(".setores_filtro");
    if (categoria === "todos") {
        setoresFiltro.classList.add("margem-top");
    } else {
        setoresFiltro.classList.remove("margem-top");
    }
}

