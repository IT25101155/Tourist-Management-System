package model;

public class User {
    private String id, username, email, password, membershipType, role, nic, telephone;
    public User(String id,String username,String email,String password,String membershipType,String role){
        this(id,username,email,password,membershipType,role,"","");
    }
    public User(String id,String username,String email,String password,String membershipType,String role,String nic,String telephone){
        this.id=id;this.username=username;this.email=email;this.password=password;this.membershipType=membershipType;this.role=role;this.nic=nic;this.telephone=telephone;
    }
    public boolean authenticate(String username,String password){return this.username.equals(username)&&this.password.equals(password);} // polymorphism can override
    public String displayType(){return "User";}
    public String toFileString(){return id+","+username+","+email+","+password+","+membershipType+","+role+","+nic+","+telephone;}
    public String getId(){return id;} public String getUsername(){return username;} public String getEmail(){return email;} public String getPassword(){return password;} public String getMembershipType(){return membershipType;} public String getRole(){return role;} public String getNic(){return nic;} public String getTelephone(){return telephone;}
}
