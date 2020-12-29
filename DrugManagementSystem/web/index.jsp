<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.min.js" type="text/javascript"></script>
    <link href="css/login.css" rel="stylesheet" type="text/css"/>
    <script src="js/login.js" type="text/javascript"></script>
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

</script>
<div class="container">
    <section id="formHolder">
        <div class="row">
            <!-- Brand Box -->
            <div class="col-sm-6 brand">
                <a href="#" class="logo">Wuliking<span>.</span></a>

                <br>
                <div class="heading">
                    <h2>医药管理系统</h2>
                    <p>Your Right Choice</p>
                </div>


                <div class="login-success-msg">
                    <P>登录成功！正在为您跳转~</P>
                </div>
                <div class="success-msg">
                    <p>棒! 现在你也是我们的成员之一啦</p>
                    <a href="#" onclick="function x() {
                      console.log('你好')
                    }" class="profile">进入系统</a>
                </div>
            </div>

            <%--            <!-- Form Box -->--%>
            <div class="col-sm-6 form">

                <!-- Login Form -->
                <div class="login form-peice">
                    <form class="login-form">
                        <div class="form-group">
                            <label for="loginAccount">账号</label>
                            <input type="text" name="account" id="loginAccount" class="loginAccount" required>
                            <span class="error"></span>
                        </div>

                        <div class="form-group">
                            <label for="loginPassword">密码</label>
                            <input type="password" name="password" id="loginPassword" class="loginPassword" required>
                            <span class="error"></span>
                        </div>

                        <div class="CTA">
                            <input type="submit" class="login" value="登录"/>
                            <%--                            <input type="submit" value="Login" >--%>
                            <a href="#" class="switch">没有账号？注册一个</a>
                            <br />
                        </div>
                        <div class="login-error">
                            <span class="error"></span>
                        </div>
                    </form>
                </div><!-- End Login Form -->

                <!-- Signup Form -->
                <div class="signup form-peice switched">
                    <form class="signup-form">

                        <div class="form-group">
                            <label for="account">请输入账号</label>
                            <input type="text" name="account" id="account" class="account">
                            <span class="error"></span>
                        </div>

                        <div class="form-group">
                            <label for="password">请输入密码</label>
                            <input type="password" name="password" id="password" class="pass">
                            <span class="error"></span>
                        </div>

                        <div class="form-group">
                            <label for="passwordCon">请再次输入密码</label>
                            <input type="password" name="passwordCon" id="passwordCon" class="passConfirm">
                            <span class="error"></span>
                        </div>

                        <div class="CTA">
                            <input type="submit" class="signup" value="注册"/>
                            <a href="#" class="switch">已有账号？点击登录</a>

                        </div>
                        <div class="signup-error">
                            <span class="error"></span>
                        </div>
                    </form>
                </div><!-- End Signup Form -->
            </div>
        </div>
    </section>
</div>

</body>
</html>
