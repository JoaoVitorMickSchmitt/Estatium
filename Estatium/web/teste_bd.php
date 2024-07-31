<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "teste_bd";

    // Criar a conexão
    $conn = new mysqli($servername, $username, $password, $dbname);
    session_start();
    ob_start();
    // Verificar a conexão
    if ($conn->connect_error) {
        die("Falha na conexão: " . $conn->connect_error);
    }
	function myDebug($cMensagem){
        $cMensagem = chr(13) . chr(10) . $cMensagem;
        $f = fopen('debug.log','a'); 
        fwrite($f,$cMensagem,strlen($cMensagem)); 
        fclose($f);
    }
    $sql = "SELECT 
	ID_PRODUTO, 
	NOME_PRODUTO, 
	DESCR_PRODUTO, 
	PRECO_PRODUTO, 
	QUALI_PRODUTO 
	FROM 
	PRODUTO ";
	$cListagem = '';
    $result = $conn->query($sql);
    if ($result->num_rows > 0){
        while($row = $result->fetch_assoc()) {
			$cListagem .= '<th scope="row" class="px-4 py-3 font-medium text-blazeOrange whitespace-nowrap">'.$row["NOME_PRODUTO"].'</th>';
			$cListagem .= '<td class="px-4 py-3">'.$row["ID_PRODUTO"].'</td>';
			$cListagem .= '<td class="px-4 py-3 max-w-[12rem] truncate">'.$row["DESCR_PRODUTO"].'</td>';
			$cListagem .= '<td class="px-4 py-3">'.$row["QUALI_PRODUTO"].'</td>';
			$cListagem .= '<td class="px-4 py-3">01-07-2024</td>';
        }
    }
	echo $cListagem;
    return;
?>