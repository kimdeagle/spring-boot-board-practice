package com.example.board.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class Logging {

	@Before("execution(* com.example.board.service.BoardServiceImpl.*(..))")
	public void beforeLog(JoinPoint joinPoint) {
		log.info("=====before log start=====");
		
	}
	
	@After("execution(* com.example.board.service.BoardServiceImpl.*(..))")
	public void afterLog(JoinPoint joinPoint) {
		log.info("=====after log start=====");
	}
	
}
