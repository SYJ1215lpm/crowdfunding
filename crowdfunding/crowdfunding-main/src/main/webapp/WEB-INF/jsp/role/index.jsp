<%--
  Created by IntelliJ IDEA.
  User: syj
  Date: 2020/2/25
  Time: 9:55
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
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="roleName" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="queryBtn" class="btn btn-warning"><i
                                class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            id="addBtn"><i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="50">序号</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <ul class="pagination">
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

<!-- 添加角色模态框 -->
<!-- Modal -->
<div class="modal fade" id="addModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加角色</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="exampleInputPassword1">角色名称</label>
                    <input type="text" class="form-control" name="roleName" placeholder="请输入角色名称">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="saveRole" class="btn btn-primary">新增</button>
            </div>
        </div>
    </div>
</div>


<!-- 修改角色模态框 -->
<!-- Modal -->
<div class="modal fade" id="updateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改角色</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="exampleInputPassword1">角色名称</label>
                    <input type="hidden" class="form-control" id="roleId" name="roleId" placeholder="请输入角色名称">
                    <input type="text" class="form-control" name="roleName" placeholder="请输入角色名称">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="updateBtn" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>


<%@ include file="/WEB-INF/jsp/common/js.jsp" %>
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
        initData(1);
    });

    // 分页查询
    var json = {
        pageNum: 1,
        pageSize: 3
    }

    function initData(pageNum) {
        json.pageNum = pageNum;
        $.ajax({
            type: "POST",
            url: "${PATH}/role/initData",
            data: json,
            beforeSend: function () {
                index = layer.load(0, {time: 3000});
                return true;
            },
            success: function (result) {
                layer.close(index);
                // 加载角色列表
                initList(result);
                // 加载角色列表导航条
                initNavg(result);
            }
        });
    }

    function initList(result) {
        $('tbody').empty();
        console.log(result);
        var list = result.list;
        $.each(list, function (i, role) {
            var tr = $('<tr></tr>');
            tr.append('<td>' + (i + 1) + '</td>');
            tr.append('<td><input type="checkbox"></td>');
            tr.append('<td>' + role.name + '</td>');
            var td = $('<td></td>');
            td.append('<button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>');
            td.append('<button type="button" roleId="' + role.id + '" class="updateClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>');
            td.append('<button type="button" roleId="' + role.id + '" class="deleteClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>');
            tr.append(td);
            tr.appendTo($('tbody'));
        });
    }

    function initNavg(result) {
        $('.pagination').empty();
        var navigatepageNums = result.navigatepageNums;
        if (result.isFirstPage) {
            $('.pagination').append($('<li class="disabled"><a href="#">上一页</a></li>'));
        } else {
            $('.pagination').append($('<li><a onclick="initData(' + (result.pageNum - 1) + ')"  >上一页</a></li>'));
        }
        $.each(navigatepageNums, function (i, navg) {
            if (navg == result.pageNum) {
                $('.pagination').append($('<li class="active"><a href="#">' + navg + ' <span class="sr-only">(current)</span></a></li>'));
            } else {
                $('.pagination').append($('<li><a onclick="initData(' + navg + ')" >' + navg + '</a></li>'));
            }
        });
        if (result.isLastPage) {
            $('.pagination').append($('<li class="disabled"><a href="#">下一页</a></li>'));
        } else {
            $('.pagination').append($('<li ><a onclick="initData(' + (result.pageNum + 1) + ')" >下一页</a></li>'));
        }
    }

    $('#queryBtn').click(function () {
        var roleName = $('#roleName').val();
        json.roleName = roleName;
        initData(1)
    });

    $('#addBtn').click(function () {
        $("#addRole").modal({
            show: true,
            backdrop: 'static'
        });
    });

    //  添加角色
    $("#saveRole").click(function () {
        var name = $("#addRole input[name='roleName']").val();
        $.ajax({
            type: "POST",
            url: "${PATH}/role/addRole",
            data: {
                name: name
            },
            beforeSend: function () {
                return true;
            },
            success: function (result) {
                if ("ok" == result) {
                    layer.msg("保存成功", {time: 2000}, function () {
                        $("#addModel").modal('hide');
                        $("#addRole input[name='roleName']").val("");
                        initData(1);
                    });
                } else {
                    layer.msg('保存失败');
                }
            }
        })
    });


    // 修改角色数据回显
    $('tbody').on('click', '.updateClass', function () {
        var roleId = $(this).attr("roleId");
        $.get("${PATH}/role/getRoleById", {id: roleId}, function (result) {
            $("#updateModel").modal({
                show: true,
                backdrop: 'static'
            });

            $("#updateModel input[name='roleName']").val(result.name);
            $("#updateModel input[name='roleId']").val(result.id);
        });
    });


    // 修改角色

    $("#updateBtn").click(function () {
        var name = $("#updateModel input[name='roleName']").val();
        var id = $("#updateModel input[name='roleId']").val();
        $.post("${PATH}/role/updateRole", {id: id, name: name}, function (result) {
                if ("ok" == result) {
                    layer.msg("修改成功", {time: 2000}, function () {
                        $("#updateModel").modal('hide');
                        // 转跳到修改数据所在页
                        initData(json.pageNum)
                    });
                } else {
                    layer.msg('修改失败');
                }
            }
        );
    });

    // 删除角色
    $('tbody').on('click', '.deleteClass', function () {
        var roleId = $(this).attr("roleId");
        layer.confirm('您是否确定删除该角色?',{btn:['确定','取消']},function(index){
            $.get("${PATH}/role/deleteRoleById", {id: roleId}, function (result) {
                if ("ok" == result) {
                    // 转跳到修改数据所在页
                    initData(json.pageNum);
                    layer.msg("删除成功", {time: 2000}, function () {

                    });
                } else {
                    layer.msg('删除失败');
                }
            });
            layer.close(index);
        },function(index){
            layer.close(index);
        });
    });


</script>
</body>
</html>

