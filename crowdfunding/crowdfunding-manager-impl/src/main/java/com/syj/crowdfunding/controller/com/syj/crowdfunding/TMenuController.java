package com.syj.crowdfunding.controller.com.syj.crowdfunding;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author SYJ
 * @description: TODO
 * @date 2020/3/2
 */
@Controller
public class TMenuController {


    @RequestMapping("/menu/index")
    public String index(){

        return "menu/index";
    }
}
