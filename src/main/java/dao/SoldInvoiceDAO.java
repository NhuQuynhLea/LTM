package dao;

import model.Customer;
import model.SoldInvoice;
import model.Staff;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class SoldInvoiceDAO extends DAO{
    public SoldInvoiceDAO() {
        super();
    }

    public ArrayList<SoldInvoice> getSoldInvoiceByMaterialStat(int materialId, Date startDate, Date endDate) {
        ArrayList<SoldInvoice> result = new ArrayList<SoldInvoice>();
        String sql = "{call getSoldInvoiceByMaterial(?, ?, ?)}";

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setInt(1, materialId);
            cs.setDate(2, new java.sql.Date(startDate.getTime()));
            cs.setDate(3, new java.sql.Date(endDate.getTime()));

            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                SoldInvoice invoice = new SoldInvoice();
                invoice.setId(rs.getInt("id"));
                invoice.setDate(rs.getDate("date"));
                Staff staff = new Staff();
                staff.setFullName(rs.getString("staff_name"));
                invoice.setStaff(staff);

                Customer customer = new Customer();
                customer.setFullName(rs.getString("customer_name"));
                invoice.setCustomer(customer);

                invoice.setQuantity(rs.getFloat("quantity"));
                invoice.setUnitPrice(rs.getFloat("price"));
                invoice.setTotalPrice(rs.getFloat("quantity") * rs.getFloat("price"));

                result.add(invoice);
            }

            rs.close();
            cs.close();
            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
