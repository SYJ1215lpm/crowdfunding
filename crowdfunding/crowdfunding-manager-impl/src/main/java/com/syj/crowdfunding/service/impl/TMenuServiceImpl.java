package com.syj.crowdfunding.service.impl;

import com.syj.crowdfunding.bean.TMenu;
import com.syj.crowdfunding.bean.TMenuExample;
import com.syj.crowdfunding.mapper.TMenuMapper;
import com.syj.crowdfunding.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.security.provider.Sun;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TMenuServiceImpl implements IMenuService {
    @Autowired
    private TMenuMapper menuMapper;

    public List<TMenu> listMenuAll() {
        List<TMenu> menuList = new ArrayList<TMenu>();
        Map<Integer, TMenu> cache = new HashMap<Integer, TMenu>();//用于为父菜单存放子菜单

        List<TMenu> allList = menuMapper.selectByExample(null);
        for (TMenu menu : allList) {
            if (menu.getPid() == 0) {
                menuList.add(menu); //添加父菜单
                cache.put(menu.getId(), menu);
            }
        }

        for (TMenu menu : allList) {
            if (menu.getPid() != 0) {
                Integer pid = menu.getPid();
                TMenu parent = cache.get(pid);
                parent.getChildren().add(menu);  // 进行父子菜单的关联
            }
        }

        return menuList;
    }

    public List<TMenu> listMenuTree() {
        TMenuExample example = new TMenuExample();
        return menuMapper.selectByExample(example);
    }

    public Boolean addMenu(TMenu menu) {
        int success = menuMapper.insert(menu);
        return success > 0;
    }
}
