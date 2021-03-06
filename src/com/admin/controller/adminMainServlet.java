package com.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.admin.model.service.AdminService;
import com.borad.model.service.BoardService;

/**
 * Servlet implementation class adminMainServlet
 */
@WebServlet("/admin/adminMain")
public class adminMainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adminMainServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int mCount=new AdminService().selectMemberCount();
		int cCount=new AdminService().selectCarCount();
		int camCount=new AdminService().selectCampingCount();
		
		request.setAttribute("mCount", mCount);
		request.setAttribute("cCount", cCount);
		request.setAttribute("camCount", camCount);
		request.getRequestDispatcher("/views/admin/adminMain.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
