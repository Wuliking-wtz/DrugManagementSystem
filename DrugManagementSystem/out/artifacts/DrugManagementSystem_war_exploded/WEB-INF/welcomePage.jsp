<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>医药管理系统</title>
    <!-- Bootstrap core CSS -->
    <link href="../resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="../resources/js/jquery.min.js" type="text/javascript"></script>
    <script src="../resources/js/sidebar.js" type="text/javascript"></script>
    <script src="../resources/js/mainpage.js" type="text/javascript"></script>
    <link href="../resources/css/sidebar.css" rel="stylesheet">
    <link href="../resources/css/mainpage.css" rel="stylesheet">
    <link href="../resources/css/dialog.css" rel="stylesheet">
    <style>
        .window {
            background-color: #E0ECFF;
            background: -webkit-linear-gradient(top, #EFF5FF 0, #E0ECFF 20%);
            background: -moz-linear-gradient(top, #EFF5FF 0, #E0ECFF 20%);
            background: -o-linear-gradient(top, #EFF5FF 0, #E0ECFF 20%);
            background: linear-gradient(to bottom, #EFF5FF 0, #E0ECFF 20%);
            background-repeat: repeat-x;
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#EFF5FF, endColorstr=#E0ECFF, GradientType=0);
        }

        .window, .window .window-body {
            border-color: #95B8E7;
        }

        .window, .window-shadow {
            position: absolute;
            -moz-border-radius: 5px 5px 5px 5px;
            -webkit-border-radius: 5px 5px 5px 5px;
            border-radius: 5px 5px 5px 5px;
        }

        .window {
            font-size: 12px;
            position: absolute;
            left: 45%;
            right: 0;
            top: 40%;
            overflow: hidden;
            padding: 5px;
            border-width: 1px;
            border-style: solid;
        }

        .panel {
            overflow: hidden;
            font-size: 12px;
            text-align: left;
        }

        .panel-title {
            padding: 5px
        }

        #editpage {
            padding: 20px 5px 5px 5px;
            background-color: #fff;
        }

        .panel-body {
            padding: 0;
        }

        .panel-title, .panel-tool {
            display: inline-block;
        }

        .panel-tool {
            margin-top: 10px;
            margin-right: 15px;
            font-size: 15px;
            float: right;
        }

        #editpage .hasError {
            color: red;
            font-size: 8px;
        }
    </style>
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

        $(function () {
            $('#confirmpw').blur(function () {
                if ($('#newpw').val() != $('#confirmpw').val()) {
                    $('#editpage .hasError').text('前后两次输入的密码不一致！');
                } else {
                    $('#editpage .hasError').text(' ');
                }
            });
            $('#editpage .confirm').click(function (event) {
                event.preventDefault();
                if ($('#newpw').val() == $('#confirmpw').val()) {
                    var data = {
                        account: $('input[name="account"]').val(),
                        oldpassword: $('#oldpw').val(),
                        password: $('#confirmpw').val(),
                        type: $('input[name="type"]').val()
                    }
                    $.ajax({
                        url: getRootPath() + "user/updateUser",
                        type: "POST",
                        dataType: "text",
                        data: data,
                        //contentType: "application/json;charset=UTF-8",
                        success: function (result) {
                            if (result == "1") {
                                $('.mask .tips span').text('修改成功！请重新登录');
                            } else if (result == '0') {
                                $('.mask .tips span').text('修改失败！');
                            } else if (result == '-1') {
                                $('.mask .tips span').text('旧密码错误！');
                            }
                            $('.mask').css('display', 'block');
                        },
                        error: function () {
                            alert("参数错误！");
                        }
                    });
                }
            });

            //提示框
            $(function () {
                $('.mask .tips button').click(function () {
                    // window.location.href=getRootPath()+"index.jsp";
                    // window.location.reload();
                    if ($('.mask .tips span').text('修改成功！请重新登录')) {
                        window.location.href = getRootPath() + "index.jsp";
                    }
                    $('.mask').css('display', 'none');
                });
            });

            $('.updatePass').click(function () {
                $('.window').css('display', 'block');

            });
            $('.window .close-button').click(function () {
                $('.window').css('display', 'none');
            });
            $('.exit').click(function () {
                let r = confirm('确认要退出吗？');
                if (r == true) {
                    window.location.href = getRootPath() + "index.jsp";
                }
            });
        });
    </script>
</head>
<body>
<div class="mask" style="display: none;">
    <div class="tips">
        <span>添加成功！</span>
        <button class="btn-primary">确定</button>
    </div>
</div>
<div class="panel window" style="display: none; width: 388px; z-index: 9002;">
    <div class="panel-header panel-header-noborder window-header" style="width: 388px;">
        <div class="panel-title panel-with-icon">修改密码</div>
        <div class="panel-tool">
            <a href="#" class="close-button">
            <span class="glyphicon glyphicon-remove">
            </span>
            </a></div>
    </div>
    <div id="dlg" title="" class="panel-body panel-body-noborder window-body"
         style="overflow: hidden; width: 386px;">
        <div class="panel" style="display: block; width: 386px;">
            <div title="" class="panel-body panel-body-noheader panel-body-noborder dialog-content"
                 style="width: 386px;">
                <div id="editpage">
                    <form id="ff">
                        <input type="hidden" name="account" value="${user.account}">
                        <input type="hidden" name="type" value="${user.type}">
                        <table width="380" border="0" align="center">
                            <tbody>
                            <tr>
                                <td align="right">旧密码：</td>
                                <td align="left"><input type="password" id="oldpw" name="oldPassword"
                                                        data-options="required:true"
                                                        class="textclass easyui-validatebox validatebox-text"></td>
                            </tr>
                            <tr>
                                <td align="right">新密码：</td>
                                <td align="left"><input type="password" id="newpw" name="password"
                                                        data-options="required:true"
                                                        class="textclass easyui-validatebox validatebox-text"></td>
                            </tr>
                            <tr>
                                <td align="right">确认密码：</td>
                                <td align="left"><input type="password" id="confirmpw" name="password"
                                                        data-options="required:true"
                                                        class="textclass easyui-validatebox validatebox-text"></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td align="left" class="hasError">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="center"></td>
                                <td>
                                    <a class="btn btn-default confirm">
                                        <span class="l-btn-left"><span class="l-btn-text icon-save l-btn-icon-left">
                                            确定
                                        </span></span>
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<nav class="topbar">
    <figure class="logo">
        <img src="../resources/img/logo.png" alt="医药管理系统">
    </figure>
    <div class="user-tips">
        <div>
            <span class="glyphicon glyphicon-user"></span>
            <span>
                <c:if test="${user.type=='总管理员'}">总管理员</c:if>
                <c:if test="${user.type=='general'}">普通用户</c:if>
                <c:if test="${user.type=='client'}">顾客管理员</c:if>
                <c:if test="${user.type=='agency'}">经办人管理员</c:if>
                <c:if test="${user.type=='medicine'}">药品信息管理员</c:if>
                <c:if test="${user.type=='sold'}">订单信息管理员</c:if>
                ,欢迎您</span>
        </div>
        <a href="#" class="updatePass">修改密码</a>
        &nbsp;&nbsp;
        <a href="#" class="exit">退出</a>
    </div>
</nav>
<nav class="page-wrapper sidebar-wrapper">
    <div class="sidebar-menu">
        <ul>
            <li class="header-menu">
                <span>常规</span>
            </li>

            <!-- 信息浏览模块 -->
            <li class="sidebar-dropdown">
                <a href="#">
                    <span>信息浏览</span>
                    <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
                </a>
                <div class="sidebar-submenu">
                    <ul>
                        <li>
                            <a href="#">
                                <span>浏览顾客信息</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>浏览经办人信息</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>浏览药品信息</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>浏览订单信息</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <!-- 信息录入模块 -->
            <li class="sidebar-dropdown">
                <a href="#">
                    <span>信息录入</span>
                    <span class="glyphicon glyphicon-chevron-down" aria-hidden="true"></span>
                </a>
                <div class="sidebar-submenu">
                    <ul>
                        <li>
                            <c:if test="${user.type=='总管理员'||user.type=='client'}">
                                <a href="#">
                                    <span>录入顾客信息</span>
                                </a>
                            </c:if>
                        </li>
                        <li>
                            <c:if test="${user.type=='总管理员'||user.type=='agency'}">
                                <a href="#">
                                    <span>录入经办人信息</span>
                                </a>
                            </c:if>
                        </li>
                        <li>
                            <c:if test="${user.type=='总管理员'||user.type=='medicine'}">
                                <a href="#">
                                    <span>录入药品信息</span>
                                </a>
                            </c:if>
                        </li>
                        <li>
                            <c:if test="${user.type=='总管理员'||user.type=='sold'}">
                                <a href="#">
                                    <span>录入订单信息</span>
                                </a>
                            </c:if>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 数据报表模块 -->
            <li class="sidebar-dropdown">
                <a href="#">
                    <span>数据报表</span>
                    <span class="glyphicon glyphicon-chevron-down i" aria-hidden="true"></span>
                </a>
                <div class="sidebar-submenu">
                    <ul>
                        <li>
                            <a href="#">
                                <span>顾客信息报表</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>经办人信息报表</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>药品信息报表</span>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <span>订单信息报表</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </li>

            <c:if test="${user.type=='总管理员'}">
                <li class="header-menu">其他</li>
                <li class="sidebar-extra">
                    <a href="#">
                        <span>权限管理</span>
                    </a>
                </li>
            </c:if>
        </ul>
    </div>

</nav>


<div class="page-content-wrapper">
    <div class="ul-tab">
        <div class="menu-button">
            <button>
                <span class="glyphicon glyphicon-menu-hamburger"></span>
                MENU
            </button>
        </div>
        <ul>
            <li class="active">
                <a href="#" class="text">
                    <span>我的桌面</span>
                </a>
                <a href="#" class="close-button">
            <span class="glyphicon glyphicon-remove">
            </span>
                </a>
            </li>
        </ul>
    </div>
    <div class="page-content">
        <div class="active" style="display: block;">
            <iframe src="showBackground" frameborder="0"></iframe>
        </div>
    </div>
</div>


</body>

</html>