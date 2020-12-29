<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html lang="en">
<head>
    <title>订单信息展示页面</title>
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
                        url: getRootPath() + "sold/batchDelete",
                        type: "POST",
                        dataType: "text",
                        data: $("input[name='deleteList']").serialize(),
                        success: function (result) {
                            if (result == "0") {
                                $('.mask .tips span').text('批量删除成功！');
                            } else {
                                $('.mask .tips span').text('编号为：' + result + '的订单删除失败');
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
                    url: getRootPath() + "sold/toSelectSold",
                    type: "POST",
                    dataType: "text",
                    data: $(".form-inline").serialize(),
                    //contentType: "application/json;charset=UTF-8",
                    success: function (result) {
                    },
                    error: function () {
                        alert("参数错误！");
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

    function getSoldPath() {
        return "sold/";
    }

    function jumpPage(page) {
        window.location.href = getRootPath() + "sold/toSelectSold?page=" + page;
    }

    function getUpdatePath(id) {
        window.location.href = getRootPath() + "sold/toUpdateSold?id=" + id;
    }

    function getDeletePath(id) {
        let r = confirm('确认要删除选中的记录吗？');
        if (r == true) {
            $.ajax({
                url: getRootPath() + "sold/batchDelete?deleteList=" + id,
                type: "POST",
                dataType: "text",
                success: function (result) {
                    if (result == "0") {
                        $('.mask .tips span').text('删除成功！');
                    } else {
                        $('.mask .tips span').text('编号为：' + result + '的订单删除失败');
                    }
                    $('.mask').css('display', 'block');

                },
                error: function () {
                    alert("参数错误！");
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
                    <label for="id">订单编号</label>
                    <input type="text" class="form-control" style="width: 160px" style="width:160px" id="id" name="id"
                           placeholder="请输入要查询的订单编号" value="${id}">
                </div>
                <div class="form-group">
                    <label for="cno">顾客编号</label>
                    <input type="text" class="form-control" id="cno" name="cno" placeholder="请输入要查询的顾客编号"
                           value="${cno}">
                </div>
                <div class="form-group">
                    <label for="ano">经办人编号</label>
                    <input type="text" class="form-control" id="ano" name="ano" placeholder="请输入要查询的经办人编号"
                           value="${ano}">
                </div>
                <button type="submit" class="btn btn-default">查询</button>
            </form>
            <c:if test="${user.type=='sold'||user.type=='总管理员'}">
                <button class="btn btn-primary deleteChecked">删除选中</button>
            </c:if>
        </div>
        <table class="table table-hover table-striped">
            <thead>
            <tr>
                <th><input type="checkbox"></th>
                <th>订单编号</th>
                <th>顾客编号</th>
                <th>药品编号</th>
                <th>经办人编号</th>
                <th>顾客症状</th>
                <th>日期</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="sold" items="${solds}">
                <tr>
                    <td><input type="checkbox" value="${sold.id}" name="deleteList"></td>
                    <td>${sold.id}</td>
                    <td>${sold.cno}</td>
                    <td>${sold.mno}</td>
                    <td>${sold.ano}</td>
                    <td>${sold.csymptom}</td>
                    <td><fmt:formatDate value="${sold.cdate}" pattern="yyyy/MM/dd"/></td>
                    <td>
                        <c:if test="${user.type=='sold'||user.type=='总管理员'}">
                            <a href="#" onclick="getUpdatePath(${sold.id})">修改</a>
                            &nbsp;|&nbsp;
                            <a href="#" onclick="getDeletePath(${sold.id})">删除</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <nav>
            <ul class="pagination">
                <c:forEach var="sold_pages" items="${sold_pages}">
                    <c:choose>
                        <c:when test="${sold_pages.active==1}">
                            <li class="active">
                                <span>${sold_pages.page}<span class="sr-only">(current)</span></span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li>
                                <a onclick="jumpPage(${sold_pages.page})" target="_self">${sold_pages.page}
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