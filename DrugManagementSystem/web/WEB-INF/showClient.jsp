<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <title>顾客信息展示页面</title>
    <link href="../resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resources/css/dialog.css" rel="stylesheet">
    <script src="../resources/js/jquery.min.js" type="text/javascript"></script>
    <style>
        .container {
            padding: 10px 0 0 10px;
            width: 95%;
        }

        .form-inline .form-group {
            padding-right: 5px;
        }

        .form-inline {
            display: inline-block;
        }

        .deleteChecked {
            float: right;
        }

        .top-bar {
            margin-top: 10px;
        }
    </style>
    <script type="text/javascript">

        $(function () {
            $("input[type=checkbox]").eq(0).click(function () {
                $("input[type=checkbox]").each(function () {
                    var checked = $("input[type=checkbox]").eq(0).prop('checked');
                    $(this).prop('checked', checked);
                })
            });

            $('.deleteChecked').click(function () {
                let r = confirm('确认要删除选中的记录吗？');
                if (r == true) {
                    $.ajax({
                        url: getRootPath() + "client/batchDelete",
                        type: "POST",
                        dataType: "text",
                        data: $("input[name='deleteList']").serialize(),
                        //contentType: "application/json;charset=UTF-8",
                        success: function (result) {
                            if (result == "0") {
                                $('.mask .tips span').text('批量删除成功！');
                            } else {
                                $('.mask .tips span').text('编号为：' + result + '的顾客删除失败');
                            }
                            $('.mask').css('display', 'block');

                        },
                        error: function () {
                            alert("未选中记录！");
                        }
                    });
                }
            });
            //查询表单
            $('.form-inline').submit(function (event) {
                //event.preventDefault();
                $.ajax({
                    url: getRootPath() + getClientPath() + "toSelectClient",
                    type: "POST",
                    dataType: "text",
                    data: $(".form-inline").serialize(),
                    //contentType: "application/json;charset=UTF-8",
                    success: function (result) {
                    },
                    error: function () {
                        alert("删除失败！该顾客已经购买过药品，请先删除相关订单信息！");
                    }
                });
            });
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

    function getClientPath() {
        return "client/";
    }

    function jumpPage(page) {
        window.location.href = getRootPath() + "client/toSelectClient?page=" + page;
    }

    function getUpdatePath(cno) {
        window.location.href = getRootPath() + "client/toUpdateClient?cno=" + cno;
    }

    function getDeletePath(cno) {
        let r = confirm('确认要删除选中的记录吗？');
        if (r == true) {
            $.ajax({
                url: getRootPath() + "client/batchDelete?deleteList=" + cno,
                type: "POST",
                dataType: "text",
                success: function (result) {
                    if (result == "0") {
                        $('.mask .tips span').text('删除成功！');
                    } else {
                        $('.mask .tips span').text('编号为：' + result + '的顾客删除失败');
                    }
                    $('.mask').css('display', 'block');

                },
                error: function () {
                    alert("删除失败！该顾客已经购买过药品，请先删除相关订单信息！");
                }
            });
        }
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
        <div class="top-bar">
            <form class="form-inline">
                <input type="hidden" name="page" value="1">
                <div class="form-group">
                    <label for="cno">编号</label>
                    <input type="text" class="form-control" id="cno" name="cno" placeholder="请输入要查询的编号" value="${cno}">
                </div>
                <div class="form-group">
                    <label for="cname">姓名</label>
                    <input type="text" class="form-control" id="cname" name="cname" placeholder="请输入要查询的姓名"
                           value="${cname}">
                </div>
                <div class="form-group">
                    <label for="caddress">地址</label>
                    <input type="text" class="form-control" id="caddress" name="caddress" placeholder="请输入要查询的地址"
                           value="${caddress}">
                </div>
                <button type="submit" class="btn btn-default">查询</button>
            </form>
            <c:if test="${user.type=='client'||user.type=='总管理员'}">
                <button class="btn btn-primary deleteChecked">删除选中</button>
            </c:if>
        </div>
        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th><input type="checkbox"></th>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>地址</th>
                <th>电话</th>
                <th>备注</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="client" items="${clients}">
                <tr>
                    <td><input type="checkbox" value="${client.cno}" name="deleteList"></td>
                    <td>${client.cno}</td>
                    <td>${client.cname}</td>
                    <td>${client.csex}</td>
                    <td>${client.caddress}</td>
                    <td>${client.cphone}</td>
                    <td>${client.cremark}</td>
                    <td>
                        <c:if test="${user.type=='client'||user.type=='总管理员'}">
                            <a href="#" onclick="getUpdatePath(${client.cno})">修改</a>
                            &nbsp;|&nbsp;
                            <a href="#" onclick="getDeletePath(${client.cno})">删除</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav>
            <ul class="pagination">
                <c:forEach var="client_page" items="${client_pages}">
                    <c:choose>
                        <c:when test="${client_page.active==1}">
                            <li class="active">
                                <span>${client_page.page}<span class="sr-only">(current)</span></span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a onclick="jumpPage(${client_page.page})" target="_self">${client_page.page}
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