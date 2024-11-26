package model;

public class ImportedMaterial {
    private int id;
    private float quantity;
    private float price;
    private Material material;

    public ImportedMaterial() {
    }

    public  ImportedMaterial(Material material, float quantity, float price) {
        this.material = material;
        this.quantity = quantity;
        this.price = price;
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

    public Material getMaterial() {
        return material;
    }

    public void setMaterial(Material material) {
        this.material = material;
    }
}
