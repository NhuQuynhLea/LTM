package model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SoldInvoice {
    private int id;
    private String code;
    private Date date;
    private int staffId;
    private int customerId;
    private List<SoldMaterial> soldMaterials;
    private Staff staff;
    private Customer customer;
    private Float quantity;

    private Float unitPrice;
    private Float totalPrice;

    // Constructor
    public SoldInvoice() {
        this.soldMaterials = new ArrayList<>();
    }

    public SoldInvoice(int id, String code, Date date, int staffId, int customerId) {
        this.id = id;
        this.code = code;
        this.date = date;
        this.staffId = staffId;
        this.customerId = customerId;
        this.soldMaterials = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public List<SoldMaterial> getSoldMaterials() {
        return soldMaterials;
    }

    public void setSoldMaterials(List<SoldMaterial> soldMaterials) {
        this.soldMaterials = soldMaterials;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Float getQuantity() {
        return quantity;
    }

    public void setQuantity(Float quantity) {
        this.quantity = quantity;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Float totalPrice) {
        this.totalPrice = totalPrice;
    }
}
