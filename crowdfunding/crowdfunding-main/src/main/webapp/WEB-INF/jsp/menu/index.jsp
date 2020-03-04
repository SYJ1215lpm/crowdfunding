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
                        initTree();
                });


                function initTree() {
                    var setting = {
                            data: {
                                simpleData: {
                                    enable: true,
                                    pIdKey:"pid"
                                }
                            },
                            view:{ // 给菜单添加图标
                                    addDiyDom: function(treeId, treeNode){//设置节点后面显示一个按钮
                                        $("#"+treeNode.tId+"_ico").removeClass();//.addClass();
                                        $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                                    },
                                    addHoverDom: function(treeId, treeNode){   //treeNode节点 -> TMenu对象设置鼠标移到节点上，在后面显示一个按钮
                                        var aObj = $("#" + treeNode.tId + "_a");
                                        aObj.attr("href","####");
                                        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                                        var s = '<span id="btnGroup'+treeNode.tId+'">';
                                        if ( treeNode.level == 0 ) { //根节点
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                                        } else if ( treeNode.level == 1 ) { //分支节点
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                                            if (treeNode.children.length == 0) {
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                                            }
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn('+treeNode.id+')">&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                                        } else if ( treeNode.level == 2 ) { //叶子节点
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn('+treeNode.id+')" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                                            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn('+treeNode.id+')" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                                        }
                                        s += '</span>';
                                        aObj.after(s);
                                    },
                                    removeHoverDom: function(treeId, treeNode){
                                        $("#btnGroup"+treeNode.tId).remove();
                                    }
                            }
                        };

                        var url = "${PATH}/menu/loadTree";
                        var json = {};
                         $.get(url,json,function(result) {
                            var zNodes = result;
                            zNodes.push({id:0,name:"系統菜单",icon:"glyphicon glyphicon-th-list"});
                            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                            treeObj.expandAll(true);
                        });
                 }


        </script>
</body>
</html>
