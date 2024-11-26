package dao;

import model.Member;

import java.sql.CallableStatement;
import java.sql.ResultSet;

public class MemberDAO extends DAO{
    public MemberDAO() {
        super();
    }

    public boolean checkLogin(Member member){
        boolean kq = false;
        if(member.getUsername().contains("true") || member.getUsername().contains("=")||
                member.getPassword().contains("true") || member.getPassword().contains("=")) return false;
        String sql = "{call checkLogin(?,?)}"; //su dung stored procedure

        try{
            CallableStatement cs = con.prepareCall(sql);
            cs.setString(1,member.getUsername());
            cs.setString(2,member.getPassword());
            ResultSet rs = cs.executeQuery();

            if(rs.next()){
                member.setId(rs.getInt("id"));
                member.setRole(rs.getString("role"));
                member.setFullName(rs.getString("fullname"));
                kq = true;
            }
        }catch(Exception e){
            e.printStackTrace();
            kq = false;
        }
        return kq;
    }
}
