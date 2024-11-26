package model;

import java.util.Date;
import java.util.List;

public class Invoice {
    private int id;
    private String code;
    private Date date;
    private float totalPrice;
    private float paidAmount;
    private Member staff;
    private Provider provider;
    private List<ImportedMaterial> importedMaterials;

    public Invoice() {
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

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public float getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(float paidAmount) {
        this.paidAmount = paidAmount;
    }

    public Member getStaff() {
        return staff;
    }

    public void setStaff(Member staff) {
        this.staff = staff;
    }

    public Provider getProvider() {
        return provider;
    }

    public void setProvider(Provider provider) {
        this.provider = provider;
    }

    public List<ImportedMaterial> getImportedMaterials() {
        return importedMaterials;
    }

    public void setImportedMaterials(List<ImportedMaterial> importedMaterials) {
        this.importedMaterials = importedMaterials;
    }
}
