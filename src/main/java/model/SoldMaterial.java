package model;

public class SoldMaterial {
    private int id;
    private float quantity;
    private float price;
    private int materialId;
    private int soldInvoiceId;

    public SoldMaterial() {}

    public SoldMaterial(int id, float quantity, float price, int materialId, int soldInvoiceId) {
        this.id = id;
        this.quantity = quantity;
        this.price = price;
        this.materialId = materialId;
        this.soldInvoiceId = soldInvoiceId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float quantity) {
        this.quantity = quantity;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getMaterialId() {
        return materialId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public int getSoldInvoiceId() {
        return soldInvoiceId;
    }

    public void setSoldInvoiceId(int soldInvoiceId) {
        this.soldInvoiceId = soldInvoiceId;
    }
}
