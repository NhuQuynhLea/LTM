package model;

public class Member extends User{
    private String username;
    private String password;
    private String role;


    public Member() {
        super();
    }

    public Member(int id,String fullName, String email,String phoneNumber, String address, String username, String password, String role) {
        super(id,fullName, email, phoneNumber, address);
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
