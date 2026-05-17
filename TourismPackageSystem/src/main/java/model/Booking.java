package model;
public class Booking{
 private String id,username,packageId,packageName,bookingDate,travelDate,status; private int persons; private double amount;
 public Booking(String id,String username,String packageId,String packageName,String bookingDate,String travelDate,int persons,double amount,String status){this.id=id;this.username=username;this.packageId=packageId;this.packageName=packageName;this.bookingDate=bookingDate;this.travelDate=travelDate;this.persons=persons;this.amount=amount;this.status=status;}
 public boolean isValidBooking(){return persons>0&&travelDate!=null&&!travelDate.isEmpty();}
 public String toFileString(){return id+","+username+","+packageId+","+packageName+","+bookingDate+","+travelDate+","+persons+","+amount+","+status;}
 public String getId(){return id;} public String getUsername(){return username;} public String getPackageId(){return packageId;} public String getPackageName(){return packageName;} public String getBookingDate(){return bookingDate;} public String getTravelDate(){return travelDate;} public int getPersons(){return persons;} public double getAmount(){return amount;} public String getStatus(){return status;}
}
