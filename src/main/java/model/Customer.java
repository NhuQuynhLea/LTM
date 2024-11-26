package model;

public class Customer extends User{
    public Customer() {}

    public Customer(int id, String name, String email, String phoneNumber, String address) {
        super(id, name, email, phoneNumber, address);
    }
}
