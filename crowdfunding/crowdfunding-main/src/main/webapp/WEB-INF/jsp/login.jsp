<%--
  Created by IntelliJ IDEA.
  User: syj
  Date: 2020/2/21
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">

    <%@ include file="/WEB-INF/jsp/common/css.jsp" %>
    <link rel="stylesheet" href="${PATH}/static/css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">众筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form id="loginForm" class="form-signin" role="form" action="doLogin" method="post">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>

        <c:if test="${not empty message}">
            <div class="form-group has-success has-feedback">
                    ${message}
            </div>
        </c:if>

        <div class="form-group has-success has-feedback">    <%--value="${param.loginacct}"--%>
            <input type="text" class="form-control" id="loginacct" name="loginacct" value="${param.loginacct}"
                   placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="password" class="form-control" id="userpswd" name="userpswd" placeholder="请输入登录密码"
                   style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <%--<div class="form-group has-success has-feedback">--%>
        <%--<select class="form-control" >--%>
        <%--<option value="member">会员</option>--%>
        <%--<option value="user">管理</option>--%>
        <%--</select>--%>
        <%--</div>--%>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="register">我要注册</a>
            </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" onclick="dologin()"> 登录</a>
    </form>
</div>
<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<script>
    function dologin() {
        var loginacct = $("#loginacct").val();
        if ($.trim(loginacct) == "") {
            layer.alert('账号不可以为空', {
                skin: 'layui-layer-lan'
                ,closeBtn: 0
                ,icon: 5
                ,anim: 1 //动画类型
            });
            return false;
        }

        var userpswd = $("#userpswd").val();
        if ($.trim(userpswd) == "") {
            layer.alert('密码不可以为空', {
                skin: 'layui-layer-lan'
                ,closeBtn: 0
                ,icon: 5
                ,anim: 1 //动画类型
            });
            return false;
        }

        $("#loginForm").submit();
    }

</script>
</body>
</html>
