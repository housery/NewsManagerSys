<%@page import="org.news.util.Page" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.text.DateFormat" %>
<%@page import="org.news.entity.Topic" %>
<%@page import="org.news.entity.News" %>
<%@page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:choose>
    <c:when test="${requestScope.list1 == null && requestScope.list2 == null && requestScope.list3 == null}">
        <jsp:forward page="/util/news?opr=listTitle"></jsp:forward>
    </c:when>
    <c:otherwise>
        <c:set var="totalPages" value="${requestScope.pageObj.totalPageCount}"/>
        <c:set var="pageIndex" value="${requestScope.pageObj.currPageNo}"/>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
    <base href="<%=basePath%>"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>新闻中国</title>
    <link href="css/main.css" rel="stylesheet" type="text/css"/>
    <script language="javascript">
        function check() {
            var login_username = document.getElementById("uname");
            var login_password = document.getElementById("upwd");
            if (login_username.value == "") {
                alert("用户名不能为空！请重新填入！");
                login_username.focus();
                return false;
            } else if (login_password.value == "") {
                alert("密码不能为空！请重新填入！");
                login_password.focus();
                return false;
            }
            return true;
        }

/*        function focusOnLogin() {
            var login_username = document.getElementById("uname");
            login_username.focus();
        }*/
    </script>
</head>

<%--<body onload="focusOnLogin()">--%>
<body>
<div id="header">
    <div id="top_login">
        <form action="${pageContext.request.contextPath}/util/user?opr=login" method="post" onsubmit="return check()">
            <label> 登录名 </label>
            <input type="text" name="uname" value="" class="login_input"/>
            <label> 密&#160;&#160;码 </label>
            <input type="password" name="upwd" value="" class="login_input"/>
            <input type="submit" class="login_sub" value="登录"/>
            <label id="error"> </label>
            <img src="images/friend_logo.gif" alt="Google" id="friend_logo"/>
        </form>
    </div>
    <div id="nav">
        <div id="logo"><img src="images/logo.jpg" alt="新闻中国"/></div>
        <div id="a_b01"><img src="images/a_b01.gif" alt=""/></div>
        <!--mainnav end-->
    </div>
</div>
<div id="container">

    <%@include file="index-elements/index_sidebar.jsp" %>

    <div class="main">
        <div class="class_type"><img src="images/class_type.gif" alt="新闻中心"/></div>
        <div class="content">
            <c:forEach items="${requestScope.list}" var="topic" varStatus="i">
                <c:if test="${i.count % 11 == 1}"><li id='class_month'></c:if>
                <a href="util/news?opr=listTitle&tid=${topic.tid}"><b>${topic.tname}</b></a>
                <c:if test="${i.count % 11 == 0}"></li></c:if>
                <c:set var="n" value="${i.count}"/>
            </c:forEach>
            <c:if test="${n % 11 != 0}"></li></c:if>
            </ul>
            <ul class="classlist">
                <c:choose>
                    <c:when test="${requestScope.list4 == null}"><h6>出现错误，请稍后再试或与管理员联系</h6></c:when>
                    <c:when test="${empty requestScope.list4}"><h6>抱歉，没有找到相关的新闻</h6></c:when>
                    <c:otherwise>
                        <c:forEach items="${requestScope.list4}" var="news" varStatus="i">
                            <li>
                                <a href='util/news?opr=readNew&nid=${news.nid}'>${news.ntitle}</a>
                                <span><fmt:formatDate value="${news.ncreatedate}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                            </li>
                            <c:if test="${i.count % 5 == 0}">
                                <li class='space'></li>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                <p align="center"> 当前页数:[${pageIndex}/${totalPages}]&nbsp;
                    <c:if test="${pageIndex > 1}">
                        <a href="util/news?opr=listTitle&pageIndex=1">首页</a>&nbsp;
                        <a href="util/news?opr=listTitle&pageIndex=${pageIndex - 1}">上一页</a>
                    </c:if>
                    <c:if test="${pageIndex < totalPages}">
                        <a href="util/news?opr=listTitle&pageIndex=${pageIndex + 1}">下一页</a>
                        <a href="util/news?opr=listTitle&pageIndex=${totalPages}">末页</a>
                    </c:if></p>
            </ul>
        </div>
        <%@ include file="index-elements/index_rightbar.jsp" %>
    </div>
</div>
<%@include file="index-elements/index_bottom.html" %>
</body>
</html>
    </c:otherwise>
</c:choose>