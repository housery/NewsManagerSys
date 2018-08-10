<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" import="java.util.*,java.sql.*,org.news.entity.*" pageEncoding="utf-8" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>添加主题--管理后台</title>
    <link href="../css/admin.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="../js/jquery_3.3.0.js"></script>
    <script src="../js/admin.js"></script>
</head>
<body>
<div id="header">
    <div id="welcome">欢迎使用新闻管理系统！</div>
    <div id="nav">
        <div id="logo"><img src="../images/logo.jpg" alt="新闻中国"/></div>
        <div id="a_b01"><img src="../images/a_b01.gif" alt=""/></div>
    </div>
</div>
<div id="admin_bar">
    <div id="status"><a href="../index.jsp">管理员： 登录 </a>&#160;&#160;&#160;&#160; <a href="#">login out</a></div>
    <div id="channel"></div>
</div>
<div id="main">
    <%@include file="console_element/left.html" %>
    <div id="msg" style="display: none;position: absolute;z-index: 5;background-color: pink;font-size: 16px;padding: 5px 20px"></div>
    <div id="opt_area">
        <ul class="classlist">
        </ul>
    </div>
</div>
<div id="footer">
    <%@include file="console_element/bottom.html" %>
</div>
</body>
</html>
