package com.syj.crowdfunding.service;

import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TRole;

import java.util.Map;

public interface IRoleService {

    PageInfo<TRole> listPageRole(Map<String, Object> mapParam);

    void saveRole(TRole role);

    TRole getRoleById(Integer id);

    void updateRole(TRole role);

    void deleteRoleById(Integer id);
}
