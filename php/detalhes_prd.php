<?php
require 'config.php';

// Obtém o ID do produto
$id = intval($_GET['id']);

// Seleciona o produto pelo ID
$sql = "SELECT * FROM produtos WHERE id=$id";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
?>
    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/php/cssphp/detalhes_prd.css">
        <link rel="stylesheet" href="/php/cssphp/header.css">
        <link rel="stylesheet" href="/php/cssphp/navbar.css">
        <link rel="stylesheet" href="/Css/menuhamb.css">
        <link rel="stylesheet" href="menuhamb.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
        <title>Produto</title>

    </head>

    <body>
        <div class="menu_escuro"></div>
        <div class="menu_hamburguer">
            <div class="menu_hidden">
                <div class="titulo_menu">
                    <h3>Navegue pelo Festmax</h3>
                    <span id="fechar_menu" class="material-symbols-outlined fechar_menu">close</span></button>
                </div>
                <div class="cat">
                    <div id="cat1" class="item">
                        <a href="produtos_acougue.html">
                            <img src="/Assets/IMG/menu_hidden/acougueiro.png" alt="Açougue">
                            <p>Açougue</p>
                        </a>
                    </div>
                    <div id="cat2" class="item">
                        <a href="produtos_frios.html">
                            <img src="/Assets/IMG/menu_hidden/queijo.png" alt="Queijo e Laticinios">
                            <p>Frios & Laticinios</p>
                        </a>
                    </div>
                    <div id="cat3" class="item">
                        <a href="produtos_padaria.html">
                            <img src="/Assets/IMG/menu_hidden/padaria.png" alt="Padaria">
                            <p>Padaria</p>
                        </a>
                    </div>
                    <div id="cat4" class="item">
                        <a href="produtos_bebidas.html">
                            <img src="/Assets/IMG/menu_hidden/licor.png" alt="Bebidas">
                            <p>Bebidas</p>
                        </a>
                    </div>
                    <div id="cat5" class="item">
                        <a href="produtos_higiene.html">
                            <img src="/Assets/IMG/menu_hidden/cleaning.png" alt="limpeza">
                            <p>Limpeza</p>
                    </div>
                    <div id="cat6" class="item">
                        <a href="produtos_hortifruti.html">
                            <img src="/Assets/IMG/menu_hidden/legumes.png" alt="Hortifrúti">
                            <p>Hortifrúti</p>
                        </a>
                    </div>
                </div>
                <div class="cat2">
                    <h3>Categorias</h3>
                    <a href="">Bebidas</a>
                    <hr>
                    <a href="">Higiene</a>
                    <hr>
                    <a href="">Mercearia</a>
                    <hr>
                    <a href="">Hortifrúti</a>
                    <hr>
                    <a href="">Adega</a>
                    <hr>
                    <a href="">Petshop</a>
                    <hr>
                    <a href="">Sorvete</a>
                    <hr>
                    <a href="">Floricultura</a>
                </div>
            </div>
        </div>
        <section class="frame01_header">
            <div id="mainframe01">
                <div class="logo pinter"><img src="Logo_FestMax.png" alt="Logo" /></div>

                <div class="actions">
                    <!-- Barra de Pesquisa -->
                    <div class="searchbar">
                        <input type="text" placeholder="Procurando Algo?" />
                        <a href="#" type="button"><i class="material-icons">search</i></a>
                    </div>
                    <!-- Icones -->
                    <div class="icon">
                        <a href="/pages/minhaconta.html">
                            <div class="icone">
                                <span class="material-symbols-outlined">contacts_product</span>
                                <div class="text_header">
                                    <p>Minha <br> conta</p>
                                </div>
                            </div>
                        </a>
                        <a href="#">
                            <div class="icone">
                                <span class="material-symbols-outlined">package_2</span>
                                <div class="text_header">
                                    <p>Meus <br> pedidos</p>
                                </div>
                            </div>
                        </a>
                        <a href="carrinho.html">
                            <div class="icone">
                                <span class="material-symbols-outlined">shopping_cart</span>
                                <div class="text_header">
                                    <p>Carrinho de <br> compras</p>
                                </div>
                            </div>
                        </a>
                        <a href="pages/nosso_time.html">
                            <div class="icone time">
                                <span class="material-symbols-outlined">diversity_4</span>
                                <div class="text_header">
                                    <p>Nosso <br> time</p>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
            </div>
        </section>
        <section class="frame01_nav">
            <nav class="nav_bar">
                <a href="#" id="menu_hamb" class="menu"><span class="material-symbols-outlined">menu</span>Todas as
                    Categorias</a>
                <a href="produtos_hortifruti.html">Hortifrúti</a>
                <a href="produtos_bebidas.html">Bebidas</a>
                <a href="produtos_padaria.html">Padaria</a>
                <a href="produtos_mercearia.html">Mercearia</a>
                <a href="produtos_higiene.html">Higiene e perfumaria</a>
                <a href="#">Sou FestMax</a>
            </nav>
        </section>

        <section class="frame05_main">
            <div class="frame05_image">
                <img src="imgfodadeexemplo.jpg">
            </div>
            <div class="frame05_content">
                <!-- Espaço dedicado ao conteúdo do produto (nome, valor, botão de compra, input de qtd, etc) -->
                <!-- Nome do produto -->
                <h1><?php echo $row["nome"]; ?></h1>
                <!-- Preço -->
                <h2 id="price">R$<?php echo number_format($row["preco"], 2, ',', '.'); ?></h2>
                <!-- input quantidade e botão adicionar ao carrinho -->
                <label name="productqtd">Quantidade</label><br>
                <div class="number-input">
                    <button onclick="this.nextElementSibling.stepDown()">–</button>
                    <input type="number" value="1" min="1" max="100">
                    <button onclick="this.previousElementSibling.stepUp()">+</button>
                    <input type="submit" value="Adicionar ao carrinho" id="submit_button">
                </div>

                <!-- Descrição do produto -->
                <p><?php echo $row["descricao"]; ?></p>
            </div>
        </section>

        <div class="footer">
            <footer>
                <div class="footer-sobre">
                    <div class="footer-icones">
                        <h2>Sobre a rede FestMax</h2>
                        <p>um mercadinho charmoso no coração da cidade, <br>
                            oferecendo produtos frescos e de qualidade <br>
                            com preços acessíveis. Venha nos visitar e <br>
                            aproveite uma experiência de compras única!
                        </p>
                        <ul class="sociais">
                            <li><a href="#"><i class="icone-facebook">facebook</i></a></li>
                            <li><a href="#"><i class="icone-twitter">twitter</i></a></li>
                            <li><a href="#"><i class="icone-instagram">instagram</i></a></li>
                        </ul>
                    </div>
                    <div class="footer-links">
                        <h2>Links Úteis</h2>
                        <ul>
                            <li><a href="#">Termos de Serviço</a></li>
                            <li><a href="#">Política de Privacidade</a></li>
                            <li><a href="#">Contato</a></li>
                        </ul>
                    </div>
                    <div class="footer-contato">
                        <h2>Contato</h2>
                        <p>Email: Suporte@festmax.com.br</p>
                        <p>Telefone: (00) 1234-5678</p>
                    </div>
                </div>
                <div class="footer-direitos">
                    &copy; 2024 FestMax. Todos os direitos reservados.
                </div>
            </footer>
        </div>

        <script src="/JavaScript/menuhamb.js"></script>
    </body>



    </html>
<?php
} else {
    echo "Produto não encontrado";
}
$conn->close();
?>