package com.syj.crowdfunding.controller;

import com.syj.crowdfunding.bean.TAdmin;
import com.syj.crowdfunding.bean.TMenu;
import com.syj.crowdfunding.service.IAdminService;
import com.syj.crowdfunding.service.IMenuService;
import com.syj.crowdfunding.util.Const;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DispatcherController {

    Logger LOG = LoggerFactory.getLogger(DispatcherController.class);

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IMenuService menuService;

    /**
     * 转跳到系统主页面
     *
     * @return
     */
    @RequestMapping("/index")
    public String index() {
        LOG.info("转跳到系统主页面");
        return "index";
    }

    /**
     * 登陆转跳
     *
     * @return
     */
    @RequestMapping("/login")
    public String login() {
        LOG.info("转跳登陆主页面");
        return "login";
    }


    /**
     * 注销
     *
     * @param session
     * @return
     */
    @RequestMapping("/loyout")
    public String loyout(HttpSession session) {
        if (null != session) {
            session.removeAttribute(Const.LOGIN_ADMIN);
            session.invalidate();
        }

        LOG.info("转跳登陆主页面");
        return "redirect:/index";
    }

    /**
     * 登陆操作
     *
     * @return
     */
    @RequestMapping("/doLogin")
    public String doLogin(String loginacct, String userpswd, HttpSession session, Model model) {
        LOG.info("开始登陆...");

        LOG.info("loginacct={}", loginacct);
        LOG.info("userpswd={}", userpswd);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("loginacct", loginacct);
        map.put("userpswd", userpswd);

        try {
            TAdmin admin = adminService.getAdminByLogin(map);
            session.setAttribute(Const.LOGIN_ADMIN, admin);
            LOG.info("登录成功...");
//            return "main";  // 避免表单的重复提交
            return "redirect:/main";
        } catch (Exception e) {
            e.printStackTrace();
            LOG.info("登录失败...");
            model.addAttribute(Const.MESSAGE, e.getMessage());
            return "login";
        }
    }


    @RequestMapping("/main")
    public String main(HttpSession session) {
        LOG.info("转跳到后台系统的main页面");
        // 存放父菜单
        if (null == session) {
            return "redirect:/login";
        }

        List<TMenu> menuList = (List<TMenu>) session.getAttribute("menuList");
        if (null == menuList) {
            menuList = menuService.listMenuAll();
            session.setAttribute("menuList", menuList);
        }
        return "main";
    }



    /**
     * 注册
     *
     * @return
     */
    @RequestMapping("/register")
    public String register() {
        LOG.info("开始注册...");
        return "register";
    }

    /**
     * 执行注册
     *
     * @return
     */
    @RequestMapping("/doRegister")
    public String doRegister(String username, String userpswd, String useremail) {
        LOG.info("开始登陆...");

        LOG.info("loginacct={}", username);
        LOG.info("userpswd={}", userpswd);
        LOG.info("useremail={}", useremail);

        return "redirect:/login";
    }

}
