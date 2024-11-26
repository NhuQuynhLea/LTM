package model;

import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Locale;

public class MaterialStat extends Material{
    private float revenue;
    private float totalQuantity;

    public MaterialStat() {
        super();
    }

    public MaterialStat(float revenue, float quantity) {
        super();
        this.revenue = revenue;
        this.totalQuantity = quantity;
    }

    public float getRevenue() {
        return revenue;
    }

    public void setRevenue(float revenue) {
        this.revenue = revenue;
    }

    public float getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(float totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
}
