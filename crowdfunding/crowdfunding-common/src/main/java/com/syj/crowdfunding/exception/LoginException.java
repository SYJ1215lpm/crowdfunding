package com.syj.crowdfunding.exception;

// Spring 事务对运行时异常默认会执行回滚操作
public class LoginException extends RuntimeException{
    public LoginException(String message) {
        super(message);
    }

    public LoginException() {

    }
}
