package com.syj.crowdfunding.service.impl;

import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TRole;
import com.syj.crowdfunding.bean.TRoleExample;
import com.syj.crowdfunding.mapper.TRoleMapper;
import com.syj.crowdfunding.service.IRoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service()
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private TRoleMapper roleMapper;


    public PageInfo<TRole> listPageRole(Map<String, Object> mapParam) {
        String roleName = (String) mapParam.get("roleName");
        TRoleExample example = new TRoleExample();
        TRoleExample.Criteria criteria = example.createCriteria();
        if (StringUtils.isNotBlank(roleName)) {
            criteria.andNameLike("%" + roleName + "%");
        }
        example.setOrderByClause("id desc");
        List<TRole> roles = roleMapper.selectByExample(example);
        PageInfo<TRole> pageInfo = new PageInfo<TRole>(roles);
        return pageInfo;
    }

    public void saveRole(TRole role) {
        roleMapper.insertSelective(role);
    }

    public TRole getRoleById(Integer id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    public void updateRole(TRole role) {
        roleMapper.updateByPrimaryKeySelective(role);
    }

    public void deleteRoleById(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }
}
