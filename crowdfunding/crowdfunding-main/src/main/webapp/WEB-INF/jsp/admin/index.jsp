<%--
  Created by IntelliJ IDEA.
  User: syj
  Date: 2020/2/22
  Time: 18:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%@ include file="/WEB-INF/jsp/common/css.jsp" %>
    <style>
        .tree li {
            list-style-type: none;
            cursor: pointer;
        }

        table tbody tr:nth-child(odd) {
            background: #F4F4F4;
        }

        table tbody td:nth-child(even) {
            color: #C00;
        }
    </style>
</head>

<body>

<%@ include file="/WEB-INF/jsp/common/top.jsp" %>



<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/jsp/common/sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" id="queryAdminList" action="index" method="post"
                          style="float:left;">
                        <div class="form-group has-feedback">

                            <div class="input-group">
                                <div class="input-group-addon">账号</div>
                                <input class="form-control has-success" value="${param.loginacct}"  name="loginacct" id="loginacct" type="text"
                                       placeholder="请输入账号">
                                <div class="input-group-addon">名称</div>
                                <input class="form-control has-success" value="${param.username}" name="username" id="username" type="text"
                                       placeholder="请输入名称">
                                <div class="input-group-addon">密码</div>
                                <input class="form-control has-success" value="${param.email}" name="email" id="email" type="text"
                                       placeholder="请输入邮箱">
                            </div>
                        </div>
                        <a class="btn btn-warning" onclick="adminList();"> 查询 </a>
                    </form>
                    <button type="button" id="deleteBatchBtn" class="btn btn-danger" style="float:right;margin-left:10px;"> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='${PATH}/admin/toAdd'"> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="selectAll" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${page.list}" var="admin" varStatus="status">
                                <tr>
                                    <td>${status.count}</td>
                                    <td><input type="checkbox" adminId="${admin.id }"></td>
                                    <td>${admin.loginacct }</td>
                                    <td>${admin.username }</td>
                                    <td>${admin.email }</td>
                                    <td>
                                        <button type="button" class="btn btn-success btn-xs"><i
                                                class=" glyphicon glyphicon-check"></i></button>
                                        <button type="button" class="btn btn-primary btn-xs"
                                                onclick="window.location.href='${PATH}/admin/toUpdate?pageNum=${page.pageNum}&id=${admin.id}'">
                                            <i class=" glyphicon glyphicon-pencil"></i></button>
                                        <button type="button" adminId="${admin.id}"
                                                class="deleteBtnClass btn btn-danger btn-xs"><i
                                                class=" glyphicon glyphicon-remove"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                        <c:if test="${page.isFirstPage }">
                                            <li class="disabled"><a href="#">上一页</a></li>
                                        </c:if>

                                        <c:if test="${!page.isFirstPage }">
                                            <li>
                                                <a href="${PATH}/admin/index?loginacct=${param.loginacct}&username=${param.username}&email=${param.email}&pageNum=${page.pageNum-1}">上一页</a>
                                            </li>
                                        </c:if>


                                        <c:forEach items="${page.navigatepageNums}" var="num">
                                            <c:if test="${num == page.pageNum }">
                                                <li class="active"><a
                                                        href="${PATH}/admin/index?loginacct=${param.loginacct}&username=${param.username}&email=${param.email}&pageNum=${num}">${num}
            `                                         <span class="sr-only">(current)</span></a></li>
                                            </c:if>
                                            <c:if test="${num != page.pageNum }">
                                                <li>
                                                    <a href="${PATH}/admin/index?loginacct=${param.loginacct}&username=${param.username}&email=${param.email}&pageNum=${num}">${num}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>


                                        <c:if test="${page.isLastPage }">
                                            <li class="disabled"><a href="#">下一页</a></li>
                                        </c:if>

                                        <c:if test="${!page.isLastPage }">
                                            <li>
                                                <a href="${PATH}/admin/index?loginacct=${param.loginacct}&username=${param.username}&email=${param.email}&pageNum=${page.pageNum+1}">下一页</a>
                                            </li>
                                        </c:if>

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
<script>
    function adminList() {
        $("#queryAdminList").submit();
    };
</script>

<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function () {
            if ($(this).find("ul")) {
                $(this).toggleClass("tree-closed");
                if ($(this).hasClass("tree-closed")) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });

    $(".deleteBtnClass").click(function () {
        var id = $(this).attr("adminId");
        console.log(id);
        layer.confirm('您是否确定删除该用户?', {btn: ['确定', '取消']}, function (index) {
            window.location.href = "${PATH}/admin/doDelete?pageNum=${page.pageNum}&id=" + id;
            layer.close(index);
        }, function (index) {
            layer.close(index);
        });
    });


    $("#selectAll").click(function(){
        //$("tbody input[type='checkbox']").attr("checked",this.checked);  //主要出现自定义属性
        $("tbody input[type='checkbox']").prop("checked",this.checked);
    });




    $("#deleteBatchBtn").click(function(){
        var checkedBoxList = $("tbody input[type='checkbox']:checked");
        console.log(checkedBoxList);

        if(checkedBoxList.length==0){
            layer.msg("请选中再删除！");
            return false ;
        }

        //var ids = '1,2,3,4,5';
        var ids = '';

        var array = new Array();
        $.each(checkedBoxList,function(i,e){
            var adminId = $(e).attr("adminId");  //获取自定义属性
            array.push(adminId);
        });

        ids = array.join(",");

        console.log(ids);
        layer.confirm('您是否确定删除已选中用户?',{btn:['确定','取消']},function(index){
            window.location.href="${PATH}/admin/doDeleteBatch?pageNum=${page.pageNum}&ids="+ids;
            layer.close(index);
        },function(index){
            layer.close(index);
        });
    });





</script>
</body>
</html>
