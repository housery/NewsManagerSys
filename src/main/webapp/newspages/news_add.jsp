<%@page import="org.news.entity.Topic" %>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="org.news.service.TopicsService" %>
<%@ page import="org.news.service.impl.TopicsServiceImpl" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>添加主题--管理后台</title>
    <link href="../css/admin.css" rel="stylesheet" type="text/css"/>
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
    <div id="status">管理员： 登录 &#160;&#160;&#160;&#160;<a href="#">login out</a></div>
    <div id="channel"></div>
</div>
<div id="main">
    <%@include file="console_element/left.html" %>
    <div id="opt_area">
        <ul class="classlist">
            <h1 id="opt_type"> 添加新闻： </h1>
            <form action="../util/news?opr=addNews" method="post" enctype="multipart/form-data">
                <p>
                    <label> 主题 </label>
                    <select name="ntid">
                        <option value=""></option>
                        <%--获取所有话题--%>
                        <% TopicsService topicsService = new TopicsServiceImpl();%>
                        <%for (Topic topic : (List<Topic>) topicsService.findAllTopics()) {%>
                        <option value='<%=topic.getTid() %>'><%=topic.getTname() %>
                        </option>
                        <%} %>
                    </select>
                </p>
                <p>
                    <label> 标题 </label>
                    <input name="ntitle" type="text" class="opt_input"/>
                </p>
                <p>
                    <label> 作者 </label>
                    <input name="nauthor" type="text" class="opt_input"/>
                </p>
                <p>
                    <label> 摘要 </label>
                    <textarea name="nsummary" cols="40" rows="3"></textarea>
                </p>
                <p>
                    <label> 内容 </label>
                    <textarea name="ncontent" cols="70" rows="10"></textarea>
                </p>
                <p>
                    <label> 上传图片 </label>
                    <input name="file" type="file" class="opt_input"/>
                </p>
                <%--ajax请求--%>
                <%--<input type="button" value="提交" class="opt_sub" id="newsAddSubmit"/>--%>
                <input type="submit" value="提交" class="opt_sub"/>
                <%--form表单提交--%>
                <input type="reset" value="重置" class="opt_sub"/>
            </form>
        </ul>
    </div>
</div>
<div id="footer">
    <%@include file="console_element/bottom.html" %>
</div>
</body>
</html>
