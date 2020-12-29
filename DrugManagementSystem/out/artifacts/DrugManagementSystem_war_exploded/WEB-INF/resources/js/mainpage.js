$(function () {
    //隐藏导航栏
    $('.menu-button>button').click(function () {
        if ($('nav.sidebar-wrapper').hasClass('active')) {
            $(this).parent().removeClass('active');
            $('nav.sidebar-wrapper').removeClass('active');
        } else {
            $(this).parent().addClass('active');
            $('nav.sidebar-wrapper').addClass('active');
        }

        if ($('.page-content-wrapper').hasClass('active')) {
            $('.page-content-wrapper').removeClass('active');
        } else {
            $('.page-content-wrapper').addClass('active');

        }
    })

    //检测右侧是否存在相同名字的标签
    function exist(text) {
        var flag = false;
        $(".page-content-wrapper .ul-tab ul").each(function () {
            if (flag)
                return;
            $(this).find('.text').each(function () {
                if (flag)
                    return;
                if ($(this).text().trim() == text) {
                    flag = true;
                    $('.page-content-wrapper .ul-tab ul li.active').removeClass('active');
                    $(this).parent().addClass('active');
                    return;
                }
            });
        });
        return flag;
    }

    $('.page-wrapper .sidebar-menu .sidebar-submenu a,\
  .page-wrapper .sidebar-menu .sidebar-extra a').click(function () {
        var url = [["顾客信息报表", getRootPath() + getClientPath() + "export"],
            ["经办人信息报表", getRootPath() + getAgencyPath() + "export"],
            ["药品信息报表", getRootPath() + getMedicinePath() + "export"],
            ["订单信息报表", getRootPath() + getSoldPath() + "export"]];
        var flag = false;
        for (var i = 0; i < url.length; i++) {
            if (this.text.trim() == url[i][0]) {
                top.location.href = url[i][1];
                flag = true;
            }
        }
        if (!flag) {
            if (!exist(this.text.trim())) {
                $('.page-content-wrapper .page-content div[style*="display: block;"]').css('display', 'none');
                $('.page-content-wrapper .ul-tab ul li.active').removeClass('active');
                var s = '<li class="active"><a href="#" class="text"><span>';
                s += this.text.trim();
                s += '</a><a href="#" class="close-button"><span class="glyphicon glyphicon-remove"></span></a></li>';
                $('.page-content-wrapper ul').append(s);
                jumpPage(this.text.trim());
            } else {
                //页面已存在
                var $now = $('.page-content-wrapper .ul-tab ul');
                for (var i = 0; i < $now.children().length; i++) {
                    if ($('.page-content-wrapper .ul-tab ul li').eq(i).text().trim() == this.text.trim()) {
                        var $temp = $('.page-content div').eq(i);
                        $('.page-content-wrapper .page-content div[style*="display: block;"]').css('display', 'none');
                        $temp.css('display', 'block');
                    }
                }
            }
        }

    });

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

    function getAgencyPath() {
        return "agency/";
    }

    function getMedicinePath() {
        return "medicine/";
    }

    function getSoldPath() {
        return "sold/";
    }

    function jumpPage(text) {
        var url = [
            ["浏览顾客信息", getRootPath() + getClientPath() + "toSelectClient?page=1"],
            ["浏览经办人信息", getRootPath() + getAgencyPath() + "toSelectAgency?page=1"],
            ["浏览药品信息", getRootPath() + getMedicinePath() + "toSelectMedicine?page=1"],
            ["浏览订单信息", getRootPath() + getSoldPath() + "toSelectSold?page=1"],
            ["录入顾客信息", getRootPath() + getClientPath() + "toAddClient"],
            ["录入经办人信息", getRootPath() + getAgencyPath() + "toAddAgency"],
            ["录入药品信息", getRootPath() + getMedicinePath() + "toAddMedicine"],
            ["录入订单信息", getRootPath() + getSoldPath() + "toAddSold"],
            ["权限管理", getRootPath() + "user/toSelectUser?page=1"]];
        for (var i = 0; i < url.length; i++) {
            if (text == url[i][0]) {
                break;
            }
        }
        if (i == url.length) {
            i = 0;
        }
        //增加页面
        $('.page-content-wrapper .page-content div.active').removeClass('active');
        var s = '<div class="active" style="display: block;"><iframe src="' + url[i][1] + '" frameborder="0"></iframe></div>'
        $(".page-content-wrapper .page-content").append(s);
    }

    // 点击网页顶部栏跳转页面
    $('.page-content-wrapper .ul-tab ul').on('click', 'li .text', function () {
        if (!$(this).parent().hasClass("active")) {
            $('.page-content-wrapper .ul-tab ul li.active').removeClass("active");
            $(this).parent().addClass("active");
            var index = $('.page-content-wrapper .ul-tab ul li').index($(this).parent()[0]);
            $('.page-content-wrapper .page-content div[style*="display: block;"]').css('display', 'none');
            $('.page-content div').eq(index).css('display', 'block');
        } else {
            //刷新页面
            var index = $('.page-content-wrapper .ul-tab ul li').index($(this).parent()[0]);
            var src = $('.page-content div').eq(index).find('iframe').attr('src');
            $('.page-content div').eq(index).find('iframe').attr('src', src);
        }
    });


    // 点击网页顶部栏关闭按钮关闭页面
    $('.page-content-wrapper .ul-tab ul').on('click', 'li .close-button', function () {

        var index = $('.page-content-wrapper .ul-tab ul li').index($(this).parent()[0]);
        if (!$(this).parent().hasClass('active')) {
            $(this).parent().remove();

        } else {
            $(this).parent().prev().addClass('active');
            $('.page-content div').eq(index - 1).css('display', 'block');
        }
        $('.page-content div').eq(index).remove();
        $(this).parent().remove();
    });
});