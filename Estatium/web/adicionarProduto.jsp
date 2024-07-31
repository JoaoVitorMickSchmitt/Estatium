<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="refresh" content="0; url=estatium-gestao.html">
        <title>Adicionar Produto</title>
    </head>
    <body>
        <%
            String nome;
            String descricao;
            float qualidadeproduto;
            int idproduto;
            String dataInspecaoStr;
            java.sql.Date dataInspecao = null;

            try {
                // Recuperar os parâmetros do formulário
                idproduto = Integer.parseInt(request.getParameter("id"));
                nome = request.getParameter("name");
                descricao = request.getParameter("descricao");
                qualidadeproduto = Float.parseFloat(request.getParameter("qualidade"));
                dataInspecaoStr = request.getParameter("inspecao");

                // Converter a string de data em java.sql.Date
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = format.parse(dataInspecaoStr);
                dataInspecao = new java.sql.Date(parsedDate.getTime());

                // Fazer conexão com o banco de dados
                Connection conecta;
                PreparedStatement st;
                Class.forName("com.mysql.cj.jdbc.Driver");
                conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/banco303", "root", "");

                // Inserir os dados na tabela produto do banco de dados
                st = conecta.prepareStatement("INSERT INTO produto (Id_Produto, Nome_Produto, Descr_Produto, Quali_Produto, Data_Fabric) VALUES (?, ?, ?, ?, ?)");
                st.setInt(1, idproduto);
                st.setString(2, nome);
                st.setString(3, descricao);
                st.setFloat(4, qualidadeproduto);
                st.setDate(5, dataInspecao);

                st.executeUpdate(); // Executa o comando insert
                // Fechar a conexão
                st.close();
                conecta.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <script>atualizarPagina();</script>
    </body>
</html>
