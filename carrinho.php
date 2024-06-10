<?php
$servername = "localhost";
$username = "seu_usuario";
$password = "sua_senha";
$dbname = "festmax";

$message = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id_cliente = $_POST['id_cliente'];
    $id_produto = $_POST['id_produto'];
    $preco_produto = $_POST['preco_produto'];
    $form_pagamento = $_POST['opcao']; // Assumindo que seja 'CRÉDITO', 'DÉBITO', 'PIX'

    try {
        $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Chamar a procedure add_to_cart
        $stmt = $conn->prepare("CALL add_to_cart(:id_cliente, :id_produto, :preco_produto)");
        $stmt->bindParam(':id_cliente', $id_cliente, PDO::PARAM_INT);
        $stmt->bindParam(':id_produto', $id_produto, PDO::PARAM_INT);
        $stmt->bindParam(':preco_produto', $preco_produto, PDO::PARAM_STR);
        $stmt->execute();

        // Chamar a procedure finalize_purchase
        $stmt = $conn->prepare("CALL finalize_purchase(:id_cliente, :form_pagamento)");
        $stmt->bindParam(':id_cliente', $id_cliente, PDO::PARAM_INT);
        $stmt->bindParam(':form_pagamento', $form_pagamento, PDO::PARAM_STR);
        $stmt->execute();

        $message = "Compra finalizada com sucesso!";
    } catch(PDOException $e) {
        $message = "Erro: " . $e->getMessage();
    }

    $conn = null;
}
?>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Carrinho</title>
    <link rel="stylesheet" href="Css/carrinho.css">
</head>
<body>
    <div class="frame03_header">
        <img src="Assets/IMG/Logo_FestMax.png">
    </div>

    <div class="frame03_lista_prdutos">
        <table>
            <tr>
                <th>Produto</th>
                <th>Nome</th>
                <th>Entrega</th>
                <th>Preço</th>
                <th>Quantidade</th>
                <th>Total</th>
            </tr>
            <tr>
                <td>
                    <a href="Index.html"><img src="Assets/IMG/ImagensGrid/cerveja.png" alt="Imagem do Produto" id="cerveja"></a>
                </td>
                <td>
                    Cerveja
                </td>
                <td>
                    A definir
                </td>
                <td>
                    R$ 7,99
                </td>
                <td>
                    <input type="number" id="quantidade" name="quantidade" value="1" min="1" max="100" onchange="calcularValorTotal()">
                </td>
                <td>
                    <input type="number" id="valor-total" name="valor-total" readonly>
                </td>
            </tr>
        </table>
    </div>

    <form action="#" method="POST" class="frame03_form">
        <input type="hidden" name="id_cliente" value="1"> <!-- Exemplo de ID de cliente -->
        <input type="hidden" name="id_produto" value="1"> <!-- Exemplo de ID de produto -->
        <input type="hidden" name="preco_produto" value="7.99">
        <p>Caso algum item falte, você deseja: *Obrigatório</p>
        <div class="opcoes">
            <label for="sele1">
                <input type="radio" id="sele1" name="opcao" value="CRÉDITO"> Substituir o produto por um de valor aproximado
            </label>
            <br>
            <label for="sele2">
                <input type="radio" id="sele2" name="opcao" value="DÉBITO"> Retornar o valor do produto
            </label>
        </div>
        <div class="enviar">
            <button type="submit" class="botao_enviar">FINALIZAR COMPRA</button>
            <a href="Index.html">Escolher mais produtos</a>
        </div>
    </form>

    <?php if (!empty($message)) : ?>
        <p><?php echo $message; ?></p>
    <?php endif; ?>

    <script src="JavaScript/carrinho.js"></script>
</body>
</html>
