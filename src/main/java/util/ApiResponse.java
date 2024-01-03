package util;


import javax.servlet.RequestDispatcher;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import javax.servlet.ServletException;
import java.io.IOException;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class ApiResponse {
	private final ServletRequest req; 
	private final ServletResponse resp; 
	
	public void sendMessage(boolean success, String message) throws ServletException, IOException { 
		RequestDispatcher rd = req.getRequestDispatcher("/api/jsonResult.jsp");
		req.setAttribute("success", success);
		req.setAttribute("message", message);
		rd.forward(req, resp);
	}
}
