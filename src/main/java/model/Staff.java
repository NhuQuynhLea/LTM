package model;

public class Staff extends Member{
    public Staff() {
        super();
    }

    public Staff(int id, String fullName, String email, String phoneNumber,
                 String address, String username, String password, String role) {
        super(id, fullName, email, phoneNumber, address, username, password, role);

    }
}
