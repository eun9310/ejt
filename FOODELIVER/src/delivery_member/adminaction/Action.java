package delivery_member.adminaction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import delivery_member.vo.ActionForward;

public interface Action{
	ActionForward execute(HttpServletRequest request,HttpServletResponse response) throws Exception;
	
}
