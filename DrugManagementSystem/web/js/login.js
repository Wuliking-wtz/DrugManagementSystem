/*global $, document, window, setTimeout, navigator, console, location*/
$(document).ready(function () {

    'use strict';

    var userAccountError = true,
        passwordError = true,
        passConfirm = true;

    var loginAccountError = true,
        loginPasswordError = true;
    if (navigator.userAgent.toLowerCase().indexOf('firefox') > -1) {
        $('.form form label').addClass('fontSwitch');
    }
    if ($('input[name=\'account\']').val() != "") {
        $('input[name=\'account\']').siblings('label').addClass('active');
    }

    // 聚焦时使标签移动
    $('input').focus(function () {
        $(this).siblings('label').addClass('active');
    });



    // 表单验证
    $('input').blur(function () {
        //登录时账号
        if ($(this).hasClass('loginAccount')) {
            if ($(this).val().length == 0) {
                $(this).siblings('span.error').text('请输入账号').fadeIn().parent('.form-group').addClass('hasError');
                loginAccountError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                loginAccountError = false;
            }
        }
        //登录时密码
        if ($(this).hasClass('loginPassword')) {
            if ($(this).val().length == 0) {
                $(this).siblings('span.error').text('').fadeIn().parent('.form-group').addClass('hasError');
                loginPasswordError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                loginPasswordError = false;
            }
        }
        // User account
        if ($(this).hasClass('account')) {
            if ($(this).val().length == 0) {
                $(this).siblings('span.error').text('请输入您要注册的账号').fadeIn().parent('.form-group').addClass('hasError');
                userAccountError = true;
            } else if ($(this).val().length > 1 && $(this).val().length < 4) {
                $(this).siblings('span.error').text('请至少输入4个字符').fadeIn().parent('.form-group').addClass('hasError');
                userAccountError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                userAccountError = false;
            }
        }

        // PassWord
        if ($(this).hasClass('pass')) {
            if ($(this).val().length == 0) {
                $(this).siblings('span.error').text('请输入密码').fadeIn().parent('.form-group').addClass('hasError');
                passwordError = true;
            } else if ($(this).val().length < 6) {
                $(this).siblings('span.error').text('请至少输入6位字符').fadeIn().parent('.form-group').addClass('hasError');
                passwordError = true;
            } else {
                $(this).siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
                passwordError = false;
            }
        }

        // PassWord confirmation
        if ($('.pass').val() !== $('.passConfirm').val()) {
            $('.passConfirm').siblings('.error').text('前后两次密码不一致！').fadeIn().parent('.form-group').addClass('hasError');
            passConfirm = false;
        } else {
            $('.passConfirm').siblings('.error').text('').fadeOut().parent('.form-group').removeClass('hasError');
            passConfirm = false;
        }

        // label effect
        if ($(this).val().length > 0) {
            $(this).siblings('label').addClass('active');
        } else {
            $(this).siblings('label').removeClass('active');
        }
    });


    // 表单切换
    $('a.switch').click(function (e) {
        $(this).toggleClass('active');
        e.preventDefault();

        if ($('a.switch').hasClass('active')) {
            $(this).parents('.form-peice').addClass('switched').siblings('.form-peice').removeClass('switched');
        } else {
            $(this).parents('.form-peice').removeClass('switched').siblings('.form-peice').addClass('switched');
        }
    });

    function getNowPath() {
        return "user/";
    }

    //登录表单被提交
    $('.login-form').submit(function (event) {
        event.preventDefault();
        if (loginAccountError == true || loginPasswordError == true) {
            $('.loginPassword, .loginAccount').blur();
        } else {
            $.ajax({
                url: getRootPath() + getNowPath() + "login",
                type: "POST",
                dataType: "text",
                data: $(".login-form").serialize(),
                //contentType: "application/json;charset=UTF-8",
                success: function (result) {
                    if ("true" == result) {
                        $('.signup, .login').addClass('switched');
                        setTimeout(function () {
                            $('.signup, .login').hide();
                        }, 700);
                        setTimeout(function () {
                            $('.brand').addClass('active');
                        }, 300);
                        setTimeout(function () {
                            $('.heading').addClass('active');
                        }, 600);
                        setTimeout(function () {
                            $('.login-success-msg p').addClass('active');
                        }, 900);
                        setTimeout(function () {
                            $('.form').hide();
                        }, 700);
                        setTimeout(function () {
                            window.location.href = getRootPath() + getNowPath() + "toWelcomePage";
                        }, 2500);
                    } else {
                        $('.login-error .error').text('账号或密码有误！').fadeIn().parent('.login-error').addClass('hasError');
                        // alert($('.login-form'));
                    }
                },
                error: function () {
                    alert("参数错误！");
                }
            });
        }
    });

    // 注册表单被提交
    $('.signup-form').submit(function (event) {
        event.preventDefault();
        if (userAccountError == true || passwordError == true || passConfirm == true) {
            $('.account, .pass, .passConfirm').blur();
        } else {
            $.ajax({
                url: getRootPath() + getNowPath() + "toSignUp",
                type: "POST",
                dataType: "text",
                data: $(".signup-form").serialize(),
                //contentType: "application/json;charset=UTF-8",
                success: function (resp) {
                    if ("true" == resp) {
                        $('.signup, .login').addClass('switched');
                        setTimeout(function () {
                            $('.signup, .login').hide();
                        }, 700);
                        setTimeout(function () {
                            $('.brand').addClass('active');
                        }, 300);
                        setTimeout(function () {
                            $('.heading').addClass('active');
                        }, 600);
                        setTimeout(function () {
                            $('.success-msg p').addClass('active');
                        }, 900);
                        setTimeout(function () {
                            $('.success-msg a').addClass('active');
                        }, 1050);
                        setTimeout(function () {
                            $('.form').hide();
                        }, 700);
                    } else {
                        $('.signup-error .error').text('该账号已存在！').fadeIn().parent('.signup-error').addClass('hasError');
                    }

                },
                error: function () {
                    //alert("参数错误");
                }
            });
        }
    });

    // Reload page
    $('a.profile').on('click', function () {
        window.location.href = getRootPath() + "user/toWelcomePage";
    });


});
