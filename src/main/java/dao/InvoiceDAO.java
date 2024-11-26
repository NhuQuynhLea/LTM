package dao;

import model.ImportedMaterial;
import model.Invoice;
import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InvoiceDAO extends DAO{
    public InvoiceDAO() {
        super();
    }
    public boolean setInvoice(Invoice invoice) {
        String sql = "{call setInvoice(?, ?, ?, ?, ?)}";
//        try {
//            CallableStatement cs = con.prepareCall(sql);
//
//            JSONArray materialsJson = new JSONArray();
//            for (ImportedMaterial material : invoice.getImportedMaterials()) {
//                JSONObject materialObj = new JSONObject();
//                materialObj.put("materialId", material.getMaterial().getId());
//                materialObj.put("quantity", material.getQuantity());
//                materialObj.put("unitPrice", material.getPrice());
//                materialsJson.put(materialObj);
//            }
//            System.out.println(materialsJson.toString());
////            cs.setString(1, invoice.getCode());
//            cs.setDate(1, new java.sql.Date(invoice.getDate().getTime()));
//            cs.setInt(2, invoice.getStaff().getId());
//            cs.setInt(3, invoice.getProvider().getId());
//            cs.setString(4, materialsJson.toString());
//            cs.registerOutParameter(5, java.sql.Types.INTEGER);
//            cs.execute();
//
//            int result = cs.getInt(6);
//            System.out.print(result);
//            cs.close();
//
//            return result > 0;
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            System.err.println("Error executing stored procedure: " + e.getMessage());
//            return false;
//        }
        try {
            // Step 1: Start a transaction
            con.setAutoCommit(false);

            // Step 2: Insert material data into a staging table
            String insertTempMaterialSQL = "INSERT INTO tempMaterialData (materialId, quantity, unitPrice) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(insertTempMaterialSQL);
            for (ImportedMaterial material : invoice.getImportedMaterials()) {
                ps.setInt(1, material.getMaterial().getId());
                ps.setDouble(2, material.getQuantity());
                ps.setDouble(3, material.getPrice());
                ps.addBatch(); // Add to batch for efficient execution
            }
            ps.executeBatch(); // Execute batch insert for material data

            // Step 3: Call the stored procedure
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, invoice.getCode()); // Set invoice code
            cs.setDate(2, new java.sql.Date(invoice.getDate().getTime())); // Set invoice date
            cs.setInt(3, invoice.getStaff().getId()); // Set staff user ID
            cs.setInt(4, invoice.getProvider().getId()); // Set provider user ID
            cs.registerOutParameter(5, java.sql.Types.INTEGER); // Register output parameter for inserted ID

            boolean procedureResult = cs.execute(); // Execute the procedure
            int insertedId = cs.getInt(5); // Retrieve the output parameter (new invoice ID)

            // Step 4: Commit the transaction if everything succeeded
            con.commit();
            System.out.println("Invoice inserted successfully. ID: " + insertedId);
            return true;

        } catch ( SQLException e) {
            e.printStackTrace();
            try {
                con.rollback(); // Rollback on error
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                con.setAutoCommit(true); // Reset auto-commit
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
