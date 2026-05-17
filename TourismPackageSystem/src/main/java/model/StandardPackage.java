package model;
public class StandardPackage extends TravelPackage{
 public StandardPackage(String id,String name,String destination,int duration,double basePrice,double discount,String description){super(id,name,destination,duration,basePrice,discount,description,"STANDARD");}
 @Override public double calculatePrice(){return Math.max(0,getBasePrice()-getDiscount());}
 public String toFileString(){return getId()+","+getName()+","+getDestination()+","+getDuration()+","+getBasePrice()+","+getDiscount()+","+getDescription().replace(","," ");}
}
