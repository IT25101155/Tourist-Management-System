package model;
public class CustomPackage extends TravelPackage{
 private String username,hotelName,transportName,activityName; private double hotelCost,transportCost,activityCost; private int persons;
 public CustomPackage(String id,String username,String destination,int duration,String hotelName,double hotelCost,String transportName,double transportCost,String activityName,double activityCost,double discount,int persons){
  super(id,"Customized",destination,duration,0,discount,"User customized package","CUSTOM"); this.username=username;this.hotelName=hotelName;this.hotelCost=hotelCost;this.transportName=transportName;this.transportCost=transportCost;this.activityName=activityName;this.activityCost=activityCost;this.persons=persons;}
 @Override public double calculatePrice(){double single=hotelCost+transportCost+activityCost; return Math.max(0,(single*persons)-getDiscount());}
 public double singlePersonPrice(){return hotelCost+transportCost+activityCost;}
 public String toFileString(){return getId()+","+username+",Customized,"+getDestination()+","+getDuration()+","+hotelName+","+hotelCost+","+transportName+","+transportCost+","+activityName+","+activityCost+","+getDiscount()+","+persons;}
 public String getUsername(){return username;} public String getHotelName(){return hotelName;} public double getHotelCost(){return hotelCost;} public String getTransportName(){return transportName;} public double getTransportCost(){return transportCost;} public String getActivityName(){return activityName;} public double getActivityCost(){return activityCost;} public int getPersons(){return persons;}
}
