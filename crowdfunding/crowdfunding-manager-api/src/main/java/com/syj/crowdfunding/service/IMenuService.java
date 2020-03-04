package com.syj.crowdfunding.service;


import com.syj.crowdfunding.bean.TMenu;

import java.util.List;

public interface IMenuService {

    /**
     * 组合父子关系
     * @return
     */
    List<TMenu> listMenuAll();

    /**
     * 初始化菜单树
     * @return
     */
    List<TMenu> listMenuTree();
}
