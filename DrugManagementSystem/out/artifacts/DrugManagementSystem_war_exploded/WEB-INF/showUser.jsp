<%--
  Created by IntelliJ IDEA.
  User: Tingze Wu
  Date: 2020/12/7
  Time: 22:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <title>权限管理页面</title>
    <link href="../resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/dialog.css" rel="stylesheet">
    <script src="../resources/js/jquery.min.js" type="text/javascript"></script>
    <style>
        .container {
            padding: 10px 0 0 10px;
            width: 95%;
        }

    </style>
    <script type="text/javascript">
        $(function () {
            $('.alter-button').click(function () {
                let r = confirm('确认要修改选中的记录吗？');
                if (r == true) {
                    // var clazz = "form-line-" + account;
                    var data = {
                        account: $(this).parent().siblings('input[name="account"]').val(),
                        password: $(this).parent().siblings('input[name="password"]').val(),
                        type: $(this).parent().siblings('.select').children('select').val()
                    };
                    $.ajax({
                        url: getRootPath() + "user/updateUser",
                        type: "POST",
                        dataType: "text",
                        data: data,
                        success: function (result) {
                            if (result == "1") {
                                $('.mask .tips span').text('修改成功！');
                            } else {
                                $('.mask .tips span').text('修改失败');
                            }
                            $('.mask').css('display', 'block');

                        },
                        error: function () {
                            alert("参数错误！");
                        }
                    });
                }
            })
        });

        //提示框
        $(function () {
            $('.mask .tips button').click(function () {
                if ($('.mask .tips span').text() != '查询成功！') {
                    window.location.reload();
                }
                $('.mask').css('display', 'none');
            });
        });

    </script>
</head>

<body>
<script type="text/javascript">
    function getRootPath() {
        //获取当前网址
        var curWwwPath = window.document.location.href;
        //获取主机地址之后的目录
        var pathName = window.document.location.pathname;
        var pos = curWwwPath.indexOf(pathName);
        //获取主机地址
        var localhostPaht = curWwwPath.substring(0, pos);
        //获取带"/“的项目名
        var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
        return (localhostPaht + projectName + "/");
    }

    function getUserPath() {
        return "user/";
    }

    function jumpPage(page) {
        window.location.href = getRootPath() + "user/toSelectUser?page=" + page;
    }

    function getUpdatePath(mno) {
        window.location.href = getRootPath() + "user/toUpdateUser?mno=" + mno;
    }


</script>

<div class="mask" style="display: none;">
    <div class="tips">
        <span>添加成功！</span>
        <button class="btn-primary">确定</button>
    </div>
</div>
<div class="container">
    <div class="row clearfix">
        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th>账号</th>
                <th>密码</th>
                <th>用户管理权限</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="user" items="${users}">
                <tr>
                    <form action="" method="post">
                        <input type="hidden" name="account" value="${user.account}">
                        <input type="hidden" name="password" value="${user.password}">
                        <td>${user.account}</td>
                        <td>${user.password}</td>
                        <td class="select">
                            <select name="type">
                                <option value="general"
                                        <c:if test="${user.type=='general'}">selected="selected"</c:if> >
                                    普通用户
                                </option>
                                <option value="client" <c:if test="${user.type=='client'}">selected="selected"</c:if>>
                                    顾客管理员
                                </option>
                                <option value="agency" <c:if test="${user.type=='agency'}">selected="selected"</c:if>>
                                    经办人管理员
                                </option>
                                <option value="medicine"
                                        <c:if test="${user.type=='medicine'}">selected="selected"</c:if>>
                                    药品信息管理员
                                </option>
                                <option value="sold" <c:if test="${user.type=='sold'}">selected="selected"</c:if>>
                                    订单信息管理员
                                </option>
                            </select>
                        </td>
                        <td>
                            <a class="alter-button" href="#">确认修改</a>
                        </td>
                    </form>

                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav>
            <ul class="pagination">
                <c:forEach var="user_pages" items="${user_pages}">
                    <c:choose>
                        <c:when test="${user_pages.active==1}">
                            <li class="active">
                                <span>${user_pages.page}<span class="sr-only">(current)</span></span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a onclick="jumpPage(${user_pages.page})" target="_self">${user_pages.page}
                                    <span class="sr-only">(current)</span>
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </ul>
        </nav>
    </div>
</div>
</body>

</html>