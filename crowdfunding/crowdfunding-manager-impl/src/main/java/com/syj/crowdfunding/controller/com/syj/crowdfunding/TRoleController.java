package com.syj.crowdfunding.controller.com.syj.crowdfunding;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TRole;
import com.syj.crowdfunding.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/role")
public class TRoleController {
    @Autowired
    private IRoleService roleService;


    /**
     * 角色首页列表跳转
     *
     * @return
     */
    @RequestMapping("/index")
    public String index() {

        return "role/index";
    }


    /**
     * 初始化角色列表数据
     *
     * @return
     */
    // 消息转换器：      httpMessageConverter
    // 返回结果是对象：  MappingJackson2XmlHttpMessageConverter   --->返回序列化的json串
    // 返回结果是String：StringHttpMessageConverter
    @RequestMapping("/initData")
    @ResponseBody
    public PageInfo<TRole> initData(@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
                                    @RequestParam(value = "pageSize", required = false, defaultValue = "3") Integer pageSize,
                                    @RequestParam(value = "roleName", required = false) String roleName) {

        PageHelper.startPage(pageNum, pageSize);
        Map<String, Object> mapParam = new HashMap<String, Object>();
        mapParam.put("roleName", roleName);
        PageInfo<TRole> page = roleService.listPageRole(mapParam);

        return page;
    }


    /**
     * 添加角色
     *
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping("/addRole")
    public String addRole(TRole role) {
        roleService.saveRole(role);
        return "ok";
    }

    /**
     * 获取角色详情
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/getRoleById")
    public TRole getRoleById(Integer id) {
        TRole role = roleService.getRoleById(id);
        return role;
    }

    /**
     * 更新角色
     *
     * @param role
     * @return
     */
    @ResponseBody
    @RequestMapping("/updateRole")
    public String updateRole(TRole role) {
        roleService.updateRole(role);
        return "ok";
    }

    /**
     * 根据主键进行删除操作
     *
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping("/deleteRoleById")
    public String deleteRoleById(Integer id) {
        roleService.deleteRoleById(id);
        return "ok";
    }

}
