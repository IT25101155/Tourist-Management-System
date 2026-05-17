package model;
public class Review{private String id,username,packageId,comment; private int rating;
 public Review(String id,String username,String packageId,int rating,String comment){this.id=id;this.username=username;this.packageId=packageId;this.rating=rating;this.comment=comment;}
 public String displayReview(){return rating+"/5 - "+comment;} public String toFileString(){return id+","+username+","+packageId+","+rating+","+comment.replace(","," ");}
 public String getId(){return id;} public String getUsername(){return username;} public String getPackageId(){return packageId;} public int getRating(){return rating;} public String getComment(){return comment;}}
