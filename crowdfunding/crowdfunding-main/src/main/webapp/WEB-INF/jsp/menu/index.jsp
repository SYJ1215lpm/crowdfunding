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
        <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单树</h3>
        </div>
        <div class="panel-body">

            <ul id="treeDemo" class="ztree"></ul>

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


        var setting = { };

        var zNodes =[
        { name:"父节点1 - 展开", open:true,
        children: [
        { name:"父节点11 - 折叠",
        children: [
        { name:"叶子节点111"},
        { name:"叶子节点112"},
        { name:"叶子节点113"},
        { name:"叶子节点114"}
        ]},
        { name:"父节点12 - 折叠",
        children: [
        { name:"叶子节点121"},
        { name:"叶子节点122"},
        { name:"叶子节点123"},
        { name:"叶子节点124"}
        ]},
        { name:"父节点13 - 没有子节点", isParent:true}
        ]},
        { name:"父节点2 - 折叠",
        children: [
        { name:"父节点21 - 展开", open:true,
        children: [
        { name:"叶子节点211"},
        { name:"叶子节点212"},
        { name:"叶子节点213"},
        { name:"叶子节点214"}
        ]},
        { name:"父节点22 - 折叠",
        children: [
        { name:"叶子节点221"},
        { name:"叶子节点222"},
        { name:"叶子节点223"},
        { name:"叶子节点224"}
        ]},
        { name:"父节点23 - 折叠",
        children: [
        { name:"叶子节点231"},
        { name:"叶子节点232"},
        { name:"叶子节点233"},
        { name:"叶子节点234"}
        ]}
        ]},
        { name:"父节点3 - 没有子节点", isParent:true}

        ];
        $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        </script>
        </body>
        </html>
