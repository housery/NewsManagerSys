$(document).ready(function () {
    addComment();
})

/**
 * 获取项目根目录
 * @returns {根目录路径}
 */
function getRootPath() {
    //获取当前网址，如： http://localhost:8088/test/test.jsp
    var curPath = window.document.location.href;
    //获取主机地址之后的目录，如： test/test.jsp
    var pathName = window.document.location.pathname;
    var pos = curPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8088
    var localhostPath = curPath.substring(0, pos);
    //获取带"/"的项目名，如：/test
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return (localhostPath + projectName);//发布前用此
}
function addComment() {
    var $formArea = $("ul.classlist").eq(2);
    var $commentInputs = $formArea.find(":input");  // 所有input
    var $commentArea = $formArea.prev("ul").children();

    $("#commentSubmit").on("click", function () {
        var paramArray = $commentInputs.serializeArray();   // 获取json格式的input内容
        var queryString = $.param(paramArray); // 转化为查询字符串
        $.getJSON(getRootPath() + "/util/news?opr=addComment", queryString, function (data) {
            if (data[0].result == "success"){
                // 评论添加成功，追加到评论区
                var $newsComment = $("<tr>\n" +
                    "    <td> 留言人：</td>\n" +
                    "    <td>cauthor</td>\n" +
                    "    <td> IP：</td>\n" +
                    "    <td>cip</td>\n" +
                    "    <td> 留言时间：</td>\n" +
                    "    <td>cdate</td>\n" +
                    "</tr>\n" +
                    "<tr>\n" +
                    "    <td colspan=\"6\">ccontent</td>\n" +
                    "</tr>\n" +
                    "<tr>\n" +
                    "    <td colspan=\"6\">\n" +
                    "        <hr/>\n" +
                    "    </td>\n" +
                    "</tr>");
                $(paramArray).each(function () {
                    // 根据变量名查找关键字替换为相应的值
                    $newsComment.find("td:contains('"+this.name+"')").text(this.value);
                });
                $newsComment.find("td:contains('cdate')").text(data[0].cdate);
                $commentArea.prepend($newsComment); //评论追加到评论头部
            } else {
                alert(data[0].result);
            }
        });
        $("#ccontent").val("");
    })
}