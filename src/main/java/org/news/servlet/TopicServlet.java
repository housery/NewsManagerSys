package org.news.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.alibaba.fastjson.JSON;
import org.news.entity.Topic;
import org.news.service.TopicsService;
import org.news.service.impl.TopicsServiceImpl;

public class TopicServlet extends HttpServlet {
    private static final long serialVersionUID = -8823896301195695638L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        String contextPath = request.getContextPath();
        String opr = request.getParameter("opr");
        TopicsService topicsService = new TopicsServiceImpl();

        if ("del".equals(opr)) { // 删除主题
            String tid = request.getParameter("tid");
            String status; // 记录执行结果
            String message; // 记录提示信息
            try {
                int result = topicsService.deleteTopic(Integer.parseInt(tid));
                if (result == -1) {
                    status = "error";
                    message = "该主题下还有文章不能删除";
                } else if (result == 0) {
                    status = "exist";
                    message = "已经存在该主题！";
                } else {
                    status = "success";
                    message = "已经删除成功";
                }
            } catch (Exception e) {
               status = "error";
               message = "删除失败，联系管理员";
            }
            out.print("[{\"status\":\""+ status + "\",\"message\":\"" + message +"\"}]");
        } else if ("update".equals(opr)) { // 更新主题,
            String tid = request.getParameter("tid");
            String tname = request.getParameter("tname");
            Topic topic = new Topic();
            topic.setTid(Integer.parseInt(tid));
            topic.setTname(tname);
            try {
                int result = topicsService.updateTopic(topic);
                if (result == -1) {
                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"当前主题已存在，请输入不同的主题！\");");
                    out.print("location.href=\"" + contextPath
                            + "/newspages/topic_modify.jsp?tid=" + tid
                            + "&tname=" + tname + "\";");
                    out.print("</script>");
                } else if (result == 0) {
                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"未找到相关主题，点击确认返回主题列表\");");
                    out.print("location.href=\"" + contextPath
                            + "/util/topics?opr=list\";");
                    out.print("</script>");
                } else {
                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"已经成功更新主题，点击确认返回主题列表\");");
                    out.print("location.href=\"" + contextPath
                            + "/util/topics?opr=list\";");
                    out.print("</script>");
                }
            } catch (Exception e) {
                out.print("<script type=\"text/javascript\">");
                out.print("alert(\"更新失败，请联系管理员！点击确认返回主题列表\");");
                out.print("location.href=\"" + contextPath
                        + "/util/topics?opr=list\";");
                out.print("</script>");
            }
        } else if (opr.equals("list")) {
            List<Topic> list = null;
            try {
                list = topicsService.findAllTopics();
            } catch (SQLException e) {
                e.printStackTrace();
                list = new ArrayList<Topic>();
            }
            /*request.setAttribute("list", list);
            request.getRequestDispatcher("/newspages/topic_list.jsp").forward(
                    request, response);*/
            // 返回ajax数据
            String topicsJSON = JSON.toJSONString(list);
            out.print(topicsJSON);
        } else if (opr.equals("add")) {// 添加主题
            String tname = request.getParameter("tname");
            String status;  //记录执行结果
            String massage; // 记录提示信息
            try {
                int result = topicsService.addTopic(tname);
                if (result == -1) {
                    status = "exist";
                    massage = "当前主题已存在，请输入不同的主题！";
            /*        out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"当前主题已存在，请输入不同的主题！\");");
                    out.print("location.href=\"" + contextPath
                            + "/newspages/topic_add.jsp\";");
                    out.print("</script>");*/
                } else {
                    status = "success";
                    massage = "主题创建成功";
/*                    out.print("<script type=\"text/javascript\">");
                    out.print("alert(\"主题创建成功，点击确认返回主题列表！\");");
                    out.print("location.href=\"" + contextPath
                            + "/util/topics?opr=list\";");
                    out.print("</script>");*/
                }
            } catch (Exception e) {
                status = "error";
                massage = "添加失败，请联系管理员!";
                /*out.print("<script type=\"text/javascript\">");
                out.print("alert(\"添加失败，请联系管理员！点击确认返回主题列表\");");
                out.print("location.href=\"" + contextPath
                        + "/util/topics?opr=list\";");
                out.print("</script>");*/
                e.printStackTrace();
            }
            String infoJSON = "[{\"status\":\"" + status + "\",\"message\":\"" + massage + "\"}]";
            out.print(infoJSON);
        } else if (opr.equals("updateByAjax")){
            String tid = request.getParameter("tid");
            String tname = request.getParameter("tname");
            Topic topic = new Topic();
            topic.setTid(Integer.parseInt(tid));
            topic.setTname(tname);
            String status;
            String message;
            try {
                int result = topicsService.updateTopic(topic);
                if (result == -1){
                    status = "exist";
                    message = "当前主题已存在，请输入不同的主题";
                } else if (result == 0){
                    status = "error";
                    message = "未找到相关主题";
                } else {
                    status = "success";
                    message = "已成功更新主题";
                }
            } catch (SQLException e) {
                status = "error";
                message = "更新失败，请联系管理员";
                e.printStackTrace();
            }
            String infoJSON = "[{\"status\":\"" + status + "\",\"message\":\"" + message +"\"}]";
            out.print(infoJSON);
        }
        out.flush();
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doGet(request, response);
    }

}
