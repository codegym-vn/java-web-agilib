<%--
  Created by IntelliJ IDEA.
  User: khoa-lap
  Date: 5/7/2018
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="config.jsp" %>
<%@ include file="functions.jsp" %>
<%

    String login = request.getParameter("login");

    if (login != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String encodedPassword = hashString(password);

        java.sql.Connection conn = null;
        try{
            Class.forName(DB_DRIVER);
            conn = java.sql.DriverManager.getConnection(DB_URL + DB_NAME, DB_USER, DB_PASSWD);

            String sqlCommand = "SELECT username,password FROM user WHERE username='" + username + "' AND password='" + encodedPassword + "'";
            java.sql.Statement statement = conn.createStatement();
            java.sql.ResultSet rs = statement.executeQuery(sqlCommand);

            if(rs.next()) {
                out.println("Đăng nhập thành công!");
            }else {
                out.println("Tài khoản\\Mật khẩu không đúng!");
            }

        } catch(Exception _ex){
            out.println("Xảy ra lỗi!!! <br />" + _ex.toString());
        }finally{
            conn.close();
        }
    }
%>

<html>
<head>
    <title>AgiLib - Đăng ký tài khoản</title>
</head>
<body>
    <ul>
        <li><a href="index.jsp" target="_self" >TRANG CHỦ</a></li>
        <li><a href="register.jsp" target="_self" >ĐĂNG KÝ</a></li>
        <li><a href="login.jsp" target="_self">ĐĂNG NHẬP</a></li>
    </ul>
    <h1>ĐĂNG NHẬP</h1>
    <form name="register-frm" method="post" action="login.jsp" >
    <table>
    <tr>
        <td>Tài khoản</td>
        <td><input type="text" name="username" required="true" /></td>
    </tr>
    <tr>
        <td>Mật khẩu</td>
        <td><input type="password" name="password" required="true" /></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <input type="submit" name="login" value="ĐĂNG NHẬP"/>
            <input type="reset" name="reset" value="HỦY BỎ" />
        </td>
    </tr>
    </table>
    </form>
</body>
</html>
