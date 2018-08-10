
$(document).ready(function () {
    var $optArea = $("#opt_area");
    var $leftLinks = $("#opt_list a");
    // 信息提示框
    var $msg = $("#msg");

    // 显示新闻列表
    initNews();

    // 添加新闻
    $leftLinks.eq(0).on("click",function () {
        // 触发servlet中toAddNews
        $optArea.load("../newspages/news_add.jsp #opt_area>*")
    })
    // 编辑新闻
    $leftLinks.eq(1).on("click",function () {
        initNews();
    });
    // 添加主题
    $leftLinks.eq(2).on("click",function () {
        // 加载topic_add.jsp下id选择器#opt_area下面的所有dom节点
        $optArea.load("../newspages/topic_add.jsp #opt_area>*");
    });
    // 编辑主题
    $leftLinks.eq(3).on("click",function () {
        initTopics();
    });

    // 添加主题
    addTopic($optArea, $msg);
    // 修改主题
    modifyTopic($optArea, $msg)
    // 删除主题
    delTopics($optArea, $msg)
    // 添加新闻
    addNews($optArea, $msg);
})

// 渐入渐出时间控制 全局变量
var fadeIn = 1000;
var fadeOut = 2000;
/**
 * 初始化新闻列表
 */
function initNews(){
    $.ajax({
        "url"       : "../util/news",
        "type"      : "GET",
        "data"      : "opr=list2",
        "dataType"  : "json",
        "success"   : function (data) {
            var $newsList = $("#opt_area>ul").empty();
            for (var i = 0; i < data.length;){
                $newsList.append("<li>" + data[i].ntitle + "<span> 作者："
                    + data[i].nauthor + " &nbsp;&nbsp;&nbsp;&nbsp;"
                    + "<a href='../util/news?opr=toModifyNews&nid=" + data[i].nid +"'>修改</a> &nbsp;&nbsp;&nbsp;&nbsp;"
                    + "<a href='../util/news?opr=delete&amp;nid="+data[i].nid+"'>删除</a> "
                    + "</span></li>")
                if ((++i) % 5 == 0){
                    $newsList.append("<li class='space'></li>");
                }
            }
        },
        "error"     : function () {
            alert("请求失败")
        }
    })
}

/**
 * 初始化话题
 */
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
                    + "<a href='javascript:;' class='tpsMdflink' id=" + data[i].tid + ":" + data[i].tname + ">修改</a> "
                    + "&#160;&#160;&#160;&#160; <a href='javascript:;' class='tpsDelLink' id="+data[i].tid+">删除</a> </li>");
                if ((++i) % 5 == 0){
                    $newsList.append("<li class='space'></li>");
                }
            }
        }
    })
}

/**
 * 添加主题
 */
function addTopic($optArea, $msg) {

    /*  换成$("#addTopicSubmit").on("click", function(){}) 选择器不起作用
    *   写在$(document).ready()里边的是dom树加载完毕后执行操作，但是$("#addTopicSubmit")在加载完文档树后是找不到的，所以不起作用
    *  $optArea原始文档树里可以找到，通过on（）再次激活查找#addTopicSubmit可以找到该对象*/
    $optArea.on("click","#addTopicSubmit",function () {
        var $tname = $optArea.find("#tname");   // 获取输入主题的文本框
        var tnameValue = $tname.val();
        // 表单验证提示错误
        if (tnameValue == ""){
            $msg.html("请输入主题名称！").fadeIn(fadeIn).fadeOut(1000);
            $tname.focus(); // 聚焦光标
            return false;
        }
        // 通过验证则发送ajax请求，添加主题
        $.getJSON("../util/topics", "opr=add&tname=" + tnameValue, function (data) {
            if (data[0].status == "success") {
                // 添加成功，显示提示信息并用ajax方式重新加载主题列表
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                initTopics();
            } else if (data[0].status == "exist"){
                // 主题已存在，显示提示信息并选中输入内容由用户重新填写
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                $tname.select();
            } else if (data[0].status == "error"){
                // 发生错误，显示提示信息并引用ajax方式重新加载主题列表
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                initTopics();
            }
        })
    })
}

/*修改主题*/
function modifyTopic($optArea, $msg) {
    $optArea.on("click", ".classlist>li .tpsMdflink", function () {
        var params = this.id.split(":") // 根据id属性值获取tid和tname
        $optArea.load("../newspages/topic_modify.jsp #opt_area>*", "tid="+params[0] + "&tname=" + params[1]);
    })

    //点击“提交”按钮注册事件，提交按钮id为updateTopicSubmit
    $optArea.on("click", "#updateTopicSubmit", function () {
        var $tname = $optArea.find("#tname");
        var tnameValue = $tname.val();
        if (tnameValue == ""){
            $msg.html("请输入主题名称！").fadeIn(fadeIn).fadeOut(fadeOut);
            return false
        }
        // 输入内容不为空
        var tidValue = $optArea.find("#tid").val();
        $.getJSON("../util/topics", "opr=updateByAjax&tname=" + tnameValue + "&tid=" + tidValue, function (data) {
            if (data[0].status == "success"){
                // 修改成功
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                // 刷新主题列表
                initTopics();
            } else if (data[0].status == "error"){
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                initTopics();
            } else {
                // 主题已经存在
                $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
                $tname.select();
            }
        })
    })
}

/*删除主题*/
function delTopics($optArea, $msg) {
    $optArea.on("click", ".classlist>li .tpsDelLink", function () {
        var $a = $(this);   // 选中的.tpsDelLink对象
        $.getJSON("../util/topics", "opr=del&tid=" + this.id, function (data) {
            $msg.html(data[0].message).fadeIn(fadeIn).fadeOut(fadeOut);
            if (data[0].status == "success"){
                /*$(this).parent().remove()   // 删除成功后移除页面相关元素，删除不掉*/
                $a.parent().remove(); // 删除该主题
            }
        })
    })
}

/*添加新闻*/
function addNews($optArea, $msg) {
    $optArea.on("click", ".classlist #newsAddSubmit", function () {
        var queryString = $optArea.find("ul :input").serialize();
        console.log(queryString);
        $.getJSON("../util/news", "opr=addNews&" + queryString, function (data) {
            $msg.html(data[0].message);
            if (data[0].status == "success"){
                initNews();  //添加成功跳转到新闻列表
            }
        })
    })
}