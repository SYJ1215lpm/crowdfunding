package com.syj.crowdfunding.service.impl;

import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TAdmin;
import com.syj.crowdfunding.bean.TAdminExample;
import com.syj.crowdfunding.exception.LoginException;
import com.syj.crowdfunding.mapper.TAdminMapper;
import com.syj.crowdfunding.service.IAdminService;
import com.syj.crowdfunding.util.AppDateUtils;
import com.syj.crowdfunding.util.Const;
import com.syj.crowdfunding.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service()
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private TAdminMapper adminMapper;

    /**
     * 登录
     *
     * @param map
     * @return
     */
    public TAdmin getAdminByLogin(Map<String, Object> map) {
        String loginacct = (String) map.get("loginacct");
        String userpswd = (String) map.get("userpswd");
        TAdminExample example = new TAdminExample();
        example.createCriteria().andLoginacctEqualTo(loginacct);
        List<TAdmin> admins = adminMapper.selectByExample(example);

        if (null == admins || admins.size() == 0) {
            throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
        }
        TAdmin admin = admins.get(0);
        if (!MD5Util.digest(userpswd).equals(admin.getUserpswd())) {
            throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
        }
        return admin;
    }


    /**
     * 用户列表
     *
     * @param paramsMap
     * @return
     */
    public PageInfo<TAdmin> listAdminPage(Map<String, Object> paramsMap) {
        String loginacct = (String) paramsMap.get("loginacct");
        String username = (String) paramsMap.get("username");
        String email = (String) paramsMap.get("email");
        TAdminExample example = new TAdminExample();
        if (null != loginacct && loginacct != "") {
            example.createCriteria().andLoginacctLike("%"+loginacct+"%");
        }
        if (null != username && username != "") {
            example.createCriteria().andUsernameLike("%"+username+"%");
        }
        if (null != email && email != "") {
            example.createCriteria().andEmailLike("%"+email+"%");
        }
        List<TAdmin> list = adminMapper.selectByExample(example);
        PageInfo<TAdmin> page = new PageInfo<TAdmin>(list);
        return page;
    }

    public void saveTAdmin(TAdmin admin) {

        admin.setUserpswd(MD5Util.digest(Const.DEFAULT_USERPSWD));

        admin.setCreatetime(AppDateUtils.getFormatTime());

        //insert into t_admin(loginacct,username,email) values(?,?,?);
        //insert into t_admin(loginacct,username,email,userpswd,createtime) values(?,?,?,?,?);
        adminMapper.insertSelective(admin); //动态sql,有选择性保存。
    }

    public TAdmin getTAdminById(Integer id) {
        return adminMapper.selectByPrimaryKey(id);
    }

    public void updateTAdmin(TAdmin admin) {
        adminMapper.updateByPrimaryKeySelective(admin);
    }

    public void deleteTAdmin(Integer id) {
        adminMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> idList) {
        adminMapper.deleteBatch(idList);
    }

}
