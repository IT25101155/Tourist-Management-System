package servlet;
import javax.servlet.*; import javax.servlet.annotation.*; import javax.servlet.http.*; import java.io.*; import model.*; import service.*;
@WebServlet({"/book-package","/update-booking","/delete-booking"})
public class BookingServlet extends HttpServlet{private BookingService bs=new BookingService(); private PackageService ps=new PackageService();
 protected void doPost(HttpServletRequest req,HttpServletResponse res)throws ServletException,IOException{String path=req.getServletPath(); User acc=(User)req.getSession().getAttribute("account"); if(acc==null){res.sendRedirect("login.jsp");return;}
  if(path.equals("/book-package")){String pid=req.getParameter("packageId"); int persons=Integer.parseInt(req.getParameter("persons")); TravelPackage p=ps.getAnyById(pid); String pname=p==null?"Package":p.getName(); double amount=ps.priceFor(pid,persons); Booking b=new Booking(req.getParameter("id"),acc.getUsername(),pid,pname,bs.today(),req.getParameter("travelDate"),persons,amount,"PENDING_PAYMENT"); bs.add(b); res.sendRedirect("payments.jsp?bookingId="+b.getId());}
  else if(path.equals("/update-booking")){int persons=Integer.parseInt(req.getParameter("persons")); Booking old=bs.getById(req.getParameter("id")); double amount=old==null?0:ps.priceFor(old.getPackageId(),persons); bs.updateBooking(req.getParameter("id"),req.getParameter("travelDate"),persons,amount); res.sendRedirect("bookings.jsp?updated=1");}
  else if(path.equals("/delete-booking")){bs.delete(req.getParameter("id"));res.sendRedirect("bookings.jsp?deleted=1");}
 }}
