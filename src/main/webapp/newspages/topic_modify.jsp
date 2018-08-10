<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="console_element/top.jsp" %>
<%--<script type="text/javascript">
    function check() {
        var tname = document.getElementById("tname");

        if (tname.value == "") {
            alert("请输入主题名称！！");
            tname.focus();
            return false;
        }
        return true;
    }
</script>--%>
<%
    String tname = request.getParameter("tname");
    //tname = new String(tname.getBytes("ISO-8859-1"),"utf-8");
%>
<div id="main">
    <%@include file="console_element/left.html" %>
    <div id="opt_area">
        <ul class="classlist">
            <h1 id="opt_type"> 修改主题： </h1>
            <form action="" method="post">
                <p>
                    <label> 主题名称 </label>
                    <input id="tname" name="tname" type="text" class="opt_input" value="<%=tname %>"/>
                    <input id="tid" name="tid" type="hidden" value="<%=request.getParameter("tid") %>">
                </p>
                <input name="action" type="hidden" value="addtopic">
                <input type="button" value="提交" class="opt_sub" id="updateTopicSubmit"/>
                <input type="reset" value="重置" class="opt_sub"/>
            </form>
        </ul>
    </div>
</div>
<%@include file="console_element/bottom.html" %>
