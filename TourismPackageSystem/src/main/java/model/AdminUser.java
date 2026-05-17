package model;
public class AdminUser extends User{
 public AdminUser(String id,String username,String email,String password,String membershipType,String role){super(id,username,email,password,membershipType,role);}
 public AdminUser(String id,String username,String email,String password,String membershipType,String role,String nic,String telephone){super(id,username,email,password,membershipType,role,nic,telephone);}
 @Override public String displayType(){return getRole().equals("HEAD_ADMIN")?"Head Admin":"Co Admin";}
}
