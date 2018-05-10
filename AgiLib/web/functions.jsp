<%@ page import="java.security.NoSuchAlgorithmException" %><%--
  Created by IntelliJ IDEA.
  User: khoa-lap
  Date: 5/7/2018
  Time: 4:11 PM
  To change this template use File | Settings | File Templates.
--%>

<%!

    public String hashString(String plainText) throws NoSuchAlgorithmException{
        java.security.MessageDigest mdAlgorithm = java.security.MessageDigest.getInstance("MD5");
        mdAlgorithm.update(plainText.getBytes());

        byte[] digest = mdAlgorithm.digest();
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < digest.length; i++) {
            plainText = Integer.toHexString(0xFF & digest[i]);

            if (plainText.length() < 2) {
                plainText = "0" + plainText;
            }

            hexString.append(plainText);
        }
        return hexString.toString();

    }

    public boolean userExisted(String username, java.sql.Connection conn) {
        try {

            java.sql.PreparedStatement pst = conn.prepareStatement("Select username,password from user where username=?");
            pst.setString(1, username);
            java.sql.ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                return true;
            }

        }catch(Exception _ex){

        }

        return false;
    }
%>