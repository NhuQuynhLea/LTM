package dao;

import model.Material;
import model.MaterialStat;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class MaterialStatDAO extends DAO{
    public MaterialStatDAO() {
        super();
    }

    public ArrayList<MaterialStat> getMaterialStat(Date startDate, Date endDate) {
        ArrayList<MaterialStat> result = new ArrayList<MaterialStat>();
        String sql = "{call getMaterialStat(?, ?)}";

        try {
            CallableStatement cs = con.prepareCall(sql);

            cs.setDate(1, new java.sql.Date(startDate.getTime()));
            cs.setDate(2, new java.sql.Date(endDate.getTime()));

            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                MaterialStat stat = new MaterialStat();
                stat.setId(rs.getInt("id"));
                stat.setName(rs.getString("name"));
                stat.setRevenue(rs.getFloat("revenue"));
                stat.setTotalQuantity(rs.getFloat("totalQuantity"));
                result.add(stat);
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
