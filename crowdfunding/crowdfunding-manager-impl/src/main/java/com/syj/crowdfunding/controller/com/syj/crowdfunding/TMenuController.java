package com.syj.crowdfunding.controller.com.syj.crowdfunding;

import com.syj.crowdfunding.bean.TMenu;
import com.syj.crowdfunding.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author SYJ
 * @description: TODO
 * @date 2020/3/2
 */
@Controller
public class TMenuController {

    @Autowired
    private IMenuService menuService;

    @RequestMapping("/menu/index")
    public String index(){
        return "menu/index";
    }


    @ResponseBody
    @RequestMapping("/menu/loadTree")
    public List<TMenu> loadTree(){
        List<TMenu>  list = menuService.listMenuTree();
        return list;
    }


}
