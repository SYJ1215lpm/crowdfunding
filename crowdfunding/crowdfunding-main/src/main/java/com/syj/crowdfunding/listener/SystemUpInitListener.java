package com.syj.crowdfunding.listener;

import com.syj.crowdfunding.util.Const;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

public class SystemUpInitListener implements ServletContextListener {
    Logger LOG = LoggerFactory.getLogger(SystemUpInitListener.class);

    // 当application创建的时候执行初始化方法
    public void contextInitialized(ServletContextEvent sc) {
        ServletContext application = sc.getServletContext();
        String contextPath = application.getContextPath();
        LOG.info("application应上下文路径：{}",contextPath);
        application.setAttribute(Const.PATH, contextPath);
    }

    // 当applicationi销毁的时候执行初始化方法
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        LOG.info("application应上下文销毁");
    }
}
