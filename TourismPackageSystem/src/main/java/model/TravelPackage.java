package model;
public abstract class TravelPackage{
 private String id,name,destination,description,type; private int duration; private double basePrice,discount;
 public TravelPackage(String id,String name,String destination,int duration,double basePrice,double discount,String description,String type){this.id=id;this.name=name;this.destination=destination;this.duration=duration;this.basePrice=basePrice;this.discount=discount;this.description=description;this.type=type;}
 public abstract double calculatePrice();
 public String displayDetails(){return name+" - "+destination+" - Rs."+calculatePrice();}
 public String getId(){return id;} public String getName(){return name;} public String getDestination(){return destination;} public int getDuration(){return duration;} public double getBasePrice(){return basePrice;} public double getDiscount(){return discount;} public String getDescription(){return description;} public String getType(){return type;}
}
