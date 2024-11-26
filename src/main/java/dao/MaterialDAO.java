package dao;

import model.Material;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MaterialDAO extends DAO{
    public MaterialDAO() {
        super();
    }

    public ArrayList<Material> searchMaterial(String searchTerm) {
        ArrayList<Material> materials = new ArrayList<>();
        String sql = "{call searchMaterial(?)}"; // Use a stored procedure

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, "%" + searchTerm + "%");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                Material material = new Material();
                material.setId(rs.getInt("id"));
                material.setName(rs.getString("name"));
                material.setDescription(rs.getString("description"));
                material.setQuantity(rs.getFloat("quantity"));
                material.setPrice(rs.getFloat("price"));
                materials.add(material);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return materials;
    }
    public boolean updateMaterial(Material material) {
        String sql = "{call updateMaterial(?, ?, ?, ?, ?)}";

        try {
            CallableStatement cs = con.prepareCall(sql);

            cs.setInt(1, material.getId());
            cs.setString(2, material.getName());
            cs.setString(3, material.getDescription());
            cs.setFloat(4, material.getQuantity());
            cs.setFloat(5, material.getPrice());

            int editMaterial = cs.executeUpdate();

            cs.close();

            return editMaterial > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addMaterial(Material material) {
        String sql = "{call addMaterial(?, ?, ?, ?)}";

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, material.getName());
            cs.setString(2, material.getDescription());
            cs.setFloat(3, 0);
            cs.setFloat(4,0);

            int addedMaterial = cs.executeUpdate();
            cs.close();
            return addedMaterial > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
