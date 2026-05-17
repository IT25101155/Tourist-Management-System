package model;
public abstract class Payment{
 private String id,username,bookingId,method,status,slipFile,adminNote; private double amount;
 public Payment(String id,String username,String bookingId,double amount,String method,String status,String slipFile,String adminNote){this.id=id;this.username=username;this.bookingId=bookingId;this.amount=amount;this.method=method;this.status=status;this.slipFile=slipFile;this.adminNote=adminNote;}
 public abstract boolean processPayment();
 public String toFileString(){return id+","+username+","+bookingId+","+amount+","+method+","+status+","+slipFile+","+adminNote.replace(","," ");}
 public String getId(){return id;} public String getUsername(){return username;} public String getBookingId(){return bookingId;} public double getAmount(){return amount;} public String getMethod(){return method;} public String getStatus(){return status;} public String getSlipFile(){return slipFile;} public String getAdminNote(){return adminNote;}
}
