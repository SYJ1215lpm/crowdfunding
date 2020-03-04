package com.syj.crowdfunding.controller.com.syj.crowdfunding;

import com.alibaba.druid.sql.PagerUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TAdmin;
import com.syj.crowdfunding.service.IAdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TAdminController {

    @Autowired
    private IAdminService adminService;

    Logger log = LoggerFactory.getLogger(TAdminController.class);


    /**
     * 用户列表
     *
     * @param pageNum
     * @param PageSize
     * @param model
     * @return
     */
    @RequestMapping("admin/index")
    public String index(@RequestParam(value = "loginacct", required = false) String loginacct,
                        @RequestParam(value = "username", required = false) String username,
                        @RequestParam(value = "email", required = false) String email,
                        @RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
                        @RequestParam(value = "PageSize", required = false, defaultValue = "3") Integer PageSize,
                        Model model) {
        Map<String, Object> paramsMap = new HashMap<String, Object>();
        paramsMap.put("loginacct",loginacct);
        paramsMap.put("username",username);
        paramsMap.put("email",email);
        PageHelper.startPage(pageNum, PageSize);
        PageInfo<TAdmin> page = adminService.listAdminPage(paramsMap);
        model.addAttribute("page", page);
        return "admin/index";
    }


    /**
     * 添加用户
     *
     * @param admin
     * @return
     */
    @RequestMapping("/admin/doAdd")
    public String doAdd(TAdmin admin) {

        adminService.saveTAdmin(admin);

        //return "redirect:/admin/index";
        return "redirect:/admin/index?pageNum=" + Integer.MAX_VALUE;
    }


    /**
     * 批量删除用户
     * @param ids
     * @param pageNum
     * @return
     */
    @RequestMapping("/admin/doDeleteBatch") //   ids = "1,2,3,4,5";
    public String doDelete(String ids, Integer pageNum) {
        List<Integer> idList = new ArrayList<Integer>();
        String[] split = ids.split(",");
        for (String idStr : split) {
            int id = Integer.parseInt(idStr);
            idList.add(id);
        }
        adminService.deleteBatch(idList);
        return "redirect:/admin/index?pageNum=" + pageNum;
    }

    @RequestMapping("/admin/doDelete")
    public String doDelete(Integer id, Integer pageNum) {

        adminService.deleteTAdmin(id);

        return "redirect:/admin/index?pageNum=" + pageNum;
    }

    @RequestMapping("/admin/doUpdate")
    public String doUpdate(TAdmin admin, Integer pageNum) {

        adminService.updateTAdmin(admin);

        return "redirect:/admin/index?pageNum=" + pageNum;
    }


    @RequestMapping("/admin/toUpdate")
    public String toUpdate(Integer id, Model model) {

        TAdmin admin = adminService.getTAdminById(id);
        model.addAttribute("admin", admin);

        return "admin/update";
    }

}
