package com.syj.crowdfunding.service;

import com.github.pagehelper.PageInfo;
import com.syj.crowdfunding.bean.TAdmin;

import java.util.List;
import java.util.Map;

public interface IAdminService {
    TAdmin getAdminByLogin(Map<String, Object> paramMap);

    PageInfo<TAdmin> listAdminPage(Map<String, Object> paramMap);

    void saveTAdmin(TAdmin admin);

    TAdmin getTAdminById(Integer id);

    void updateTAdmin(TAdmin admin);

    void deleteTAdmin(Integer id);

    void deleteBatch(List<Integer> idList);
}
