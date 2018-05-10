<%@ page import="java.sql.SQLException" %><%--
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
    String register = request.getParameter("register");
    if (register != null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");

        java.sql.Connection conn = null;

        try {
            Class.forName(DB_DRIVER);
            conn = java.sql.DriverManager.getConnection(DB_URL + DB_NAME, DB_USER, DB_PASSWD);

            boolean check = true;
            if (userExisted(username, conn)) {
                check = false;
                out.print("Tài khoản này đã tồn tại!");
            }

            if (!password.equals(repassword)) {
                check = false;
                out.print("Mật khẩu và Mật khẩu nhập lại không giống nhau!");
            }

            if (check) {
                String encodedPassword = hashString(password);
                String sql  = "INSERT INTO user (username, password) VALUES (?, ?)";
                java.sql.PreparedStatement preStm = conn.prepareStatement(sql);
                preStm.setString(1, username);
                preStm.setString(2, encodedPassword);
                preStm.execute();

            }
        }catch(SQLException se){
            //Handle errors for JDBC
            se.printStackTrace();
        }catch(Exception e){
            //Handle errors for Class.forName
            e.printStackTrace();
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
    <h1>ĐĂNG KÝ TÀI KHOẢN</h1>
    <form name="register-frm" method="post" action="register.jsp" >
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
        <td>Nhập lại Mật khẩu</td>
        <td><input type="password" name="repassword" required="true" /></td>
    </tr>
    <tr>
        <td></td>
        <td><input type="submit" name="register" value="ĐĂNG KÝ"/> <input type="reset" name="reset" value="HỦY BỎ" /></td>
    </tr>
    </table>
    </form>
</body>
</html>
