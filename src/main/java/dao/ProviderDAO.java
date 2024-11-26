package dao;

import model.Material;
import model.Provider;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ProviderDAO extends DAO{
    public ProviderDAO() {
        super();
    }

    public ArrayList<Provider> searchProvider(String searchTerm) {
        ArrayList<Provider> providers = new ArrayList<>();
        String sql = "{call searchProvider(?)}"; // Use a stored procedure

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, "%" + searchTerm + "%");
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                Provider provider = new Provider();
                provider.setId(rs.getInt("id"));
                provider.setFullName(rs.getString("fullname"));
                provider.setAddress(rs.getString("address"));
                provider.setPhoneNumber(rs.getString("phoneNumber"));
                provider.setEmail(rs.getString("email"));
                providers.add(provider);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

        return providers;
    }

    public boolean addProvider(Provider provider) {
        String sql = "{call addProvider(?, ?, ?, ?)}";

        try {
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1, provider.getFullName());
            cs.setString(2, provider.getAddress());
            cs.setString(3, provider.getPhoneNumber());
            cs.setString(4, provider.getEmail());

            int addedProvider = cs.executeUpdate();
            cs.close();
            return addedProvider > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
