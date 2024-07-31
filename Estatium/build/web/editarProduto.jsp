<%-- 
    Document   : editarProduto
    Created on : 2 de jul. de 2024, 09:23:04
    Author     : joao_v_schmitt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Alterar Produto</h1>
    <%
        // Verifica se foi enviado um código válido via parâmetro 'codigo'
        String codigoParam = request.getParameter("codigo");
        if (codigoParam != null && !codigoParam.isEmpty()) {
            try {
                int codigo = Integer.parseInt(codigoParam);

                // Conexão com o banco de dados
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Conectar ao banco de dados
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco303", "root", "");

                    // Consulta SQL para obter os dados do produto
                    String sql = "SELECT * FROM produto WHERE Id_Produto = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, codigo);
                    rs = pstmt.executeQuery();

                    // Se encontrar o produto, atribui os valores aos campos do formulário
                    if (rs.next()) {
                        String nomeProduto = rs.getString("Nome_Produto");
                        String descricaoProduto = rs.getString("Descr_Produto");
                        double precoProduto = rs.getDouble("Preco_Produto");
                        Date dataFabricacao = rs.getDate("Data_Fabric");
                        Date prazoValidade = rs.getDate("Prazo_Validade");
                        float qualidadeProduto = rs.getFloat("Quali_Produto");
                        String corProduto = rs.getString("Cor_Produto");
                        int idPedido = rs.getInt("Id_pedido");
    %>
    <form method="post" action="mudanca.jsp">
        <p>
            <label for="codigo">Código do produto</label>
            <input type="text" name="codigo" id="codigo" value="<%=codigo%>" readonly>
        </p>
        
        <p>
            <label for="nome">Nome do produto</label> 
            <input type="text" name="nome" id="nome" size="50" maxlength="50" value="<%=nomeProduto%>">
        </p>
        
        <p>
            <label for="descricao">Descrição do produto</label> 
            <input type="text" name="descricao" id="descricao" size="50" maxlength="50" value="<%=descricaoProduto%>">
        </p>
        
        <p>
            <label for="preco">Preço do produto</label> 
            <input type="text" name="preco" id="preco" value="<%=precoProduto%>">
        </p>
        
        <p>
            <label for="datafabric">Data de fabricação</label> 
            <input type="text" name="datafabric" id="datafabric" value="<%=dataFabricacao != null ? new SimpleDateFormat("yyyy-MM-dd").format(dataFabricacao) : "" %>">
        </p>
        
        <p>
            <label for="prazovalida">Prazo de validade</label> 
            <input type="text" name="prazovalida" id="prazovalida" value="<%=prazoValidade != null ? new SimpleDateFormat("yyyy-MM-dd").format(prazoValidade) : "" %>">
        </p>
        
        <p>
            <label for="qualiproduto">Qualidade do produto</label> 
            <input type="text" name="qualiproduto" id="qualiproduto" value="<%=qualidadeProduto%>">
        </p>
        
        <p>
            <label for="corproduto">Cor do produto</label> 
            <input type="text" name="corproduto" id="corproduto" size="50" maxlength="50" value="<%=corProduto%>">
        </p>
        
        <p>
            <label for="idpedido">Id do pedido</label> 
            <input type="text" name="idpedido" id="idpedido" size="50" maxlength="50" value="<%=idPedido%>" readonly>
        </p>
        
        <p>
            <input type="submit" value="Salvar">
        </p>
    </form>
    <%
                    } else {
                        // Se não encontrar o produto, exibe uma mensagem de erro
                        out.println("Produto não encontrado.");
                    }

                } catch (Exception e) {
                    out.println("Erro ao buscar produto: " + e.getMessage());
                    // e.printStackTrace(out); // Comentado para corrigir o erro
                } finally {
                    // Fechar recursos
                    try { if (rs != null) rs.close(); } catch (Exception e) { /* ignored */ }
                    try { if (pstmt != null) pstmt.close(); } catch (Exception e) { /* ignored */ }
                    try { if (conn != null) conn.close(); } catch (Exception e) { /* ignored */ }
                }

            } catch (NumberFormatException e) {
                out.println("Código do produto inválido.");
                // e.printStackTrace(out); // Comentado para corrigir o erro
            }
        } else {
            // Se não houver código válido, exibe uma mensagem de erro
            out.println("Código do produto não fornecido.");
        }
    %>
    </body>
</html>
