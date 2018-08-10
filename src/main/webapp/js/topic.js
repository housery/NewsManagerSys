$(document).ready(function () {
    // 初始化话题列表
    function initTopics() {
        $.ajax({
            "url"       : "../util/topics",
            "type"      : "post",
            "data"      : "opr=list",
            "dataType"  : "json",
            "success"   : function (data) {
                var $newsList = $("#opt_area>ul").empty();
                for (var i = 0; i < data.length;){
                    $newsList.append("<li> &#160;&#160;&#160;&#160; "+data[i].tname+" &#160;&#160;&#160;&#160; "
                        + "<a href='../newspages/topic_modify.jsp?tid="+ data[i].tid + "&" + data[i].tname + "'>修改</a> "
                        + "&#160;&#160;&#160;&#160; <a href='../util/topics?opr=del&tid="+data[i].tid+"'>删除</a> </li>")
                    if ((++i) % 5 == 0){
                        $newsList.append("<li class='space'></li>");
                    }
                }
            }
        })
    }

// 删除话题
    function clickdelTopic(tid) {
        if (confirm("此新闻的相关评论也将删除，确定删除吗？")) {
            window.location = "../util/topics?opr=del&amp;tid=" + tid;
        }
    }
    var $leftLinks = $("#opt_list a");
    // $leftLinks.eq(1).click(initNews());
    $leftLinks.eq(1).click(initTopics());
})