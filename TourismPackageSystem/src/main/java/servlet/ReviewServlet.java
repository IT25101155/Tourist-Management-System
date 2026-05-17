package servlet;
import javax.servlet.*; import javax.servlet.annotation.*; import javax.servlet.http.*; import java.io.*; import model.*; import service.ReviewService;
@WebServlet({"/add-review","/update-review","/delete-review"})
public class ReviewServlet extends HttpServlet{private ReviewService rs=new ReviewService();
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{User acc=(User)req.getSession().getAttribute("account"); if(acc==null){res.sendRedirect("login.jsp");return;} String path=req.getServletPath(); boolean admin=!acc.getRole().equals("CUSTOMER");
  if(path.equals("/add-review")){if(admin){res.sendRedirect("reviews.jsp");return;} rs.add(new Review(req.getParameter("id"),acc.getUsername(),req.getParameter("packageId"),Integer.parseInt(req.getParameter("rating")),req.getParameter("comment")));res.sendRedirect("reviews.jsp?added=1");}
  else if(path.equals("/update-review")){if(admin){res.sendRedirect("reviews.jsp");return;} rs.update(new Review(req.getParameter("id"),acc.getUsername(),req.getParameter("packageId"),Integer.parseInt(req.getParameter("rating")),req.getParameter("comment")),acc.getUsername());res.sendRedirect("reviews.jsp?updated=1");}
  else if(path.equals("/delete-review")){rs.delete(req.getParameter("id"),acc.getUsername(),admin);res.sendRedirect("reviews.jsp?deleted=1");}
 }}
