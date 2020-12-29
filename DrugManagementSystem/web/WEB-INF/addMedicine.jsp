<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>录入药品</title>
    <link href="../resources/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="../resources/js/jquery.min.js" type="text/javascript"></script>
    <link href="../resources/css/dialog.css" rel="stylesheet">
    <style>
        .container {
            padding: 10px 0 0 10px;
            width: 95%;
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
        function getMedicinePath() {
            return "medicine/";
        }
        //提示框
        $(function () {
            $('.mask .tips button').click(function () {
                window.location.reload();
                $('.mask').css('display', 'none');
            });
        });
        $(function () {
            $('.form').submit(function (event) {
                event.preventDefault();
                $.ajax({
                    url: getRootPath() + getMedicinePath() + "addMedicine",
                    type: "POST",
                    dataType: "text",
                    data: $(".form").serialize(),
                    //contentType: "application/json;charset=UTF-8",
                    success: function (result) {
                        if(result=="1") {
                            $('.mask .tips span').text('添加成功！');
                            $('.mask').css('display', 'block');
                        }else if(result=='0') {
                            $('.mask .tips span').text('添加失败！');
                            $('.mask').css('display', 'block');
                        }
                    },
                    error: function () {
                        alert("参数错误！");
                    }
                });
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
<div class="container">
    <div class="row clearfix">
        <div class="col-md-12">
            <div class="pmefficacy-header">
                <h1>
                    <small>新增药品信息</small>
                </h1>
            </div>
        </div>

        <form action="#" method="post" class="form">
            <div class="form-group">
                <label for="mname">药品名字</label>
                <input type="text" class="form-control" id="mname" name="mname" required>
            </div>
            <div class="form-group">
                <label for="mmode">药品服用方法</label>
                <input type="text" class="form-control" id="mmode" name="mmode" required>
            </div>
            <div class="form-group">
                <label for="mefficacy">药品功效</label>
                <input type="text" class="form-control" id="mefficacy" name="mefficacy" required>
            </div>
            <div class="form-group">
                <input type="submit" class="form-control btn-primary" value="添加">
            </div>
        </form>
    </div>
</div>
</body>
</html>
