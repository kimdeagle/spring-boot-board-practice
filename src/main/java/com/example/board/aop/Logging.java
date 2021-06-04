package com.example.board.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import lombok.extern.slf4j.Slf4j;

@Aspect
@Component
@Slf4j
public class Logging {
	
	@Around("execution(* com.example.board.service.BoardServiceImpl.*(..))")
	public Object aroundLog(ProceedingJoinPoint pjp) throws Throwable {
		StopWatch stopWatch = new StopWatch();
		stopWatch.start();
		
		Object proceed = pjp.proceed();
		
		stopWatch.stop();
		
		log.info(stopWatch.getTotalTimeMillis() + "ms");
		
		return proceed;
		
	}
	
}
