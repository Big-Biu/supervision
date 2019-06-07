package cn.edu.wic.supervision;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

@Component
public class MyExceptionResolver implements HandlerExceptionResolver
{

	@Override
	public ModelAndView resolveException(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler, 
			Exception exception)
	{
		ModelAndView mv = new ModelAndView();
		
		if(exception instanceof DataAccessException){
			mv.setViewName("error/exception_dao");
			mv.addObject("message", "请检查你的数据库, <a href='mailto:11698008@qq.com'>联系我</a>");
		}else{
			mv.setViewName("error/exception");
			mv.addObject("message", "请联系管理员修改bug，<a href='mailto:11698008@qq.com'>联系我</a>");
		}
		
		return mv;
	}

}
