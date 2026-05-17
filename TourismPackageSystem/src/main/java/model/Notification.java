package model;
public class Notification{
 private String id,username,title,message,status;
 public Notification(String id,String username,String title,String message,String status){this.id=id;this.username=username;this.title=title;this.message=message;this.status=status;}
 public String toFileString(){return id+","+username+","+title.replace(","," ")+","+message.replace(","," ")+","+status;}
 public String getId(){return id;} public String getUsername(){return username;} public String getTitle(){return title;} public String getMessage(){return message;} public String getStatus(){return status;}
}
