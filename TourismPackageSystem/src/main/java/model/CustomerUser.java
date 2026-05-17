package model;
public class CustomerUser extends User{
 public CustomerUser(String id,String username,String email,String password,String membershipType){super(id,username,email,password,membershipType,"CUSTOMER");}
 public CustomerUser(String id,String username,String email,String password,String membershipType,String nic,String telephone){super(id,username,email,password,membershipType,"CUSTOMER",nic,telephone);}
 @Override public String displayType(){return "Customer";}
}
