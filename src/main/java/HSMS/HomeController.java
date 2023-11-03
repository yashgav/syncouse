/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package HSMS;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


/**
 *
 * @author Yash
 */
@Controller()
public class HomeController {

    UserDetails ud = new UserDetails();
    logins ld = new logins();
    maintainance mb = new maintainance();
    SendEmail se = new SendEmail();

    @RequestMapping("/home")
    public String home(Model m) {
//        String x="yash";
//        x="y";
//        m.addAttribute("name",x);
        return "home";
    }

    @RequestMapping("registerpage")
    public String registerpage(
            Map<String, Object> ob1
    ) {

        ob1.put("ud1", ud);

        System.out.println("in register");
        return "register";
    }

    @RequestMapping(value = "registerpage_next", method = RequestMethod.POST)
    public String createsociety(
            @ModelAttribute("ud1") UserDetails udm,
            Map<String, Object> model
    ) {
        System.out.println("in next");

        System.out.println(udm.age + udm.city + udm.username + udm.password);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");

            System.out.println("adding in database");

            PreparedStatement stmt1 = con.prepareStatement("SELECT * FROM USERDETAILS ORDER BY ID DESC LIMIT 1");
            int n = 0;
            ResultSet rs = stmt1.executeQuery();
            while (rs.next()) {

                n = rs.getInt("ID");
            }
            int j = n + 1;
            PreparedStatement stmt = con.prepareStatement("INSERT INTO USERDETAILS VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

            System.out.println(udm.role + "  " + j + udm.city + udm.dob + udm.username + udm.flatno + "emials: " + udm.email);

            if (udm.role.equals("Admin")) {
                System.out.println("admins");
                stmt.setString(1, udm.role);
                stmt.setString(2, udm.sname);
                stmt.setInt(3, j);
                stmt.setString(4, udm.gender);
                stmt.setString(5, udm.martial);//1 specifies the first parameter in the query  
                stmt.setString(6, udm.fname);//1 specifies the first parameter in the query  
                stmt.setString(7, udm.lname);
                stmt.setString(8, udm.dob);//1 specifies the first parameter in the query  
                stmt.setString(9, udm.age);
                stmt.setString(10, udm.city);
                stmt.setString(11, udm.district);
                stmt.setString(12, udm.state);
                stmt.setString(13, udm.pincode);
                stmt.setString(14, udm.username);
                stmt.setString(15, udm.password);
                stmt.setString(16, udm.mname);
                stmt.setString(17, udm.ascode);
                stmt.setString(18, udm.flatno);
                stmt.setString(19, udm.email);
                stmt.executeUpdate();
                se.mailing("syncouse.society@gmail.com", passs, "syncouse.society@gmail.com", udm.email, udm.fname, udm.username, udm.sname, udm.ascode, 1);
                    
           
                return "home";
            } else {
               
                System.out.println("in else");
                PreparedStatement stmt3 = con.prepareStatement("SELECT * FROM USERDETAILS WHERE ROLE='Admin' and scode=?");
                stmt3.setString(1, udm.mscode);
                ResultSet rs3 = stmt3.executeQuery();
                int f = 0;
                System.out.println(udm.mscode);
                String scode = null, sn = null;
                while (rs3.next()) {
                    scode = rs3.getString("scode");
                    sn = rs3.getString("sname");
                }

                System.out.println(scode);
                if (scode.equals(udm.mscode)) {
                    System.out.println("found scode");
                    System.out.println("members");
                    stmt.setString(1, udm.role);
                    stmt.setString(2, sn);
                    stmt.setInt(3, j);
                    stmt.setString(4, udm.gender);
                    stmt.setString(5, udm.martial);//1 specifies the first parameter in the query  
                    stmt.setString(6, udm.fname);//1 specifies the first parameter in the query  
                    stmt.setString(7, udm.lname);
                    stmt.setString(8, udm.dob);//1 specifies the first parameter in the query  
                    stmt.setString(9, udm.age);
                    stmt.setString(10, udm.city);
                    stmt.setString(11, udm.district);
                    stmt.setString(12, udm.state);
                    stmt.setString(13, udm.pincode);
                    stmt.setString(14, udm.username);
                    stmt.setString(15, udm.password);
                    stmt.setString(16, udm.mname);
                    stmt.setString(17, udm.mscode);
                    stmt.setString(18, udm.flatno);
                    stmt.setString(19, udm.email);
                    stmt.executeUpdate();
                    se.mailing("syncouse.society@gmail.com", passs, "syncouse.society@gmail.com", udm.email, udm.fname,udm.username,  udm.sname, udm.mscode, 0);
                   PreparedStatement stmt20 = con.prepareStatement("CREATE TABLE "+udm.username+"_"+udm.mscode+"_BILL(id int,ROLETYPE VARCHAR(20),SCODE VARCHAR(20),FLATNO VARCHAR(20),USERNAME VARCHAR(20),BILLTYPE VARCHAR(30),AMOUNT INT,STATUS VARCHAR(10),ISSUEDATE VARCHAR(20),DUEDATE VARCHAR(20));");
                    stmt20.executeUpdate();
                    return "home";
                } else {
                    System.out.println("not found scode");
                    return "invalidscode";
                }
            }

        } catch (Exception e) {
        }
        return "invalidscode";
    }

    @RequestMapping("admin_personal_profile")
    public String personal_profile(
            Model m,
            @RequestParam("user") String user
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("role", ld.role);
        m.addAttribute("flat", ld.flatno);
        return "personal_profile_admin";
    }

    @RequestMapping("member_personal_profile")
    public String memberpersonal_profile(
            Model m,
            @RequestParam("user") String user
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("role", ld.role);
        m.addAttribute("flat", ld.flatno);
        return "personal_profile_member";
    }

    @RequestMapping("admin_check_profile")
    public String check_profile(
            Model m,
            @RequestParam("user") String user,
            @RequestParam("flat") String flat,
            @RequestParam("role") String role
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("user", user);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("role", role);
        m.addAttribute("flat", flat);
        return "personal_profile_admin";
    }

    @RequestMapping("member_check_profile")
    public String membercheck_profile(
            Model m,
            @RequestParam("user") String user,
            @RequestParam("flat") String flat,
            @RequestParam("role") String role
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("user", user);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("role", role);
        m.addAttribute("flat", flat);
        return "personal_profile_member";
    }

    @RequestMapping("adminlogin")
    public String adminlogin(
            @RequestParam("auser") String x,
            @RequestParam("apass") String y,
            @RequestParam("scode") String z,
            Model m
    ) {
        try {
            System.out.println("reached to register proccessing");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println(x + y + z);
            PreparedStatement stmt = con.prepareStatement("SELECT * FROM USERDETAILS WHERE ROLE='Admin' AND USERNAME=? AND PASSWORD=? and scode=?");

            stmt.setString(1, x);
            stmt.setString(2, y);
            stmt.setString(3, z);
            int n = 0;
            String user = null, pass = null, sc = null, fn = null;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                user = rs.getString("USERNAME");
                pass = rs.getString("PASSWORD");
                sc = rs.getString("scode");
                n = rs.getInt("ID");
                fn = rs.getString("FLATNO");
            }

            if (x.equals(user)) {
                if (y.equals(pass)) {
                    if (z.equals(sc)) {
                        ld.username = user;
                        ld.password = pass;
                        ld.scode = sc;
                        ld.role = "Admin";
                        ld.flatno = fn;
                        m.addAttribute("user", user);
                        m.addAttribute("un", user);
                        m.addAttribute("scode", sc);
                        m.addAttribute("userid", n);
                        m.addAttribute("flatno", fn);
                        return "admin/dashboard";
                    }
                }
            }

            stmt.executeUpdate();
        } catch (Exception e) {
        }
        return "login_error";
    }

    @RequestMapping("memberlogin")
    public String memberlogin(
            @RequestParam("muser") String x,
            @RequestParam("mpass") String y,
            @RequestParam("scode") String z,
            Model m
    ) {
        try {
            System.out.println("reached to register proccessing");
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM USERDETAILS WHERE ROLE='Member' AND USERNAME=? AND PASSWORD=? and scode=?");

            stmt.setString(1, x);
            stmt.setString(2, y);
            stmt.setString(3, z);
            int n = 0;
            String user = null, pass = null, sc = null, fn = null;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                user = rs.getString("USERNAME");
                pass = rs.getString("PASSWORD");
                sc = rs.getString("scode");
                fn = rs.getString("FLATNO");
                n = rs.getInt("ID");
            }

            if (x.equals(user)) {
                if (y.equals(pass)) {
                    if (z.equals(sc)) {
                        ld.username = user;
                        ld.password = pass;
                        ld.scode = sc;
                        ld.flatno = fn;
                        ld.role = "Member";
                        m.addAttribute("userid", n);
                        m.addAttribute("user", user);
                        m.addAttribute("un", user);
                        m.addAttribute("scode", sc);
                        return "member/dashboard";
                    }
                }

            }

            stmt.executeUpdate();
        } catch (Exception e) {
        }
        return "login_error";
    }

//    admin dashboard
    @RequestMapping("admin_members")
    public String admin_members(
            Model m
    ) {
        System.out.println(ud.age + ud.fname + ud.mname);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        return "admin/members";
    }

    @RequestMapping("admin_home")
    public String admin_home(
            Model m
    ) {
        System.out.println(ud.age + ud.fname + ud.mname);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
       
        return "admin/dashboard";
    }

    @RequestMapping("admin_payments")
    public String admin_payments(
            Map<String, Object> ob1,
            Model m
    ) {
        System.out.println(ud.age + ud.fname + ud.mname);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        System.out.println("username: " + ld.username);
        ob1.put("mb1", mb);

        return "admin/payments";
    }
    String passs = "msdltcqdsoxicrem";

    
    @RequestMapping("maintainancebill")
    public String maintainancebill(
            @ModelAttribute("mb1") maintainance mba,
            Model m
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("scode", ld.scode);
        m.addAttribute("user", ld.username);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println("maintainace scode" + ld.scode);
            PreparedStatement stmt1 = con.prepareStatement("SELECT * FROM maintainance where scode=?");
            stmt1.setString(1, ld.scode);
            ResultSet rs = stmt1.executeQuery();
            String scode = null;
            int f = 0;
            System.out.println(mba.clean);
            int tot = mba.general + mba.water + mba.electricity + mba.muncipal + mba.clean + mba.parking + mba.lift;
            System.out.println("total=" + tot);
            while (rs.next()) {
                scode = rs.getString("SCODE");
                System.out.println(scode);

            }
            if (scode == null) {

                PreparedStatement stmt3 = con.prepareStatement("INSERT INTO maintainance VALUES(?,?,?,?,?,?,?,?,?)");
                stmt3.setInt(1, mba.general);
                stmt3.setInt(2, mba.water);
                stmt3.setInt(3, mba.muncipal);
                stmt3.setInt(4, mba.clean);
                stmt3.setInt(5, mba.electricity);
                stmt3.setInt(6, mba.parking);
                stmt3.setInt(7, mba.lift);
                stmt3.setInt(8, tot);
                stmt3.setString(9, ld.scode);

                stmt3.executeUpdate();
            } else {

                PreparedStatement stmt2 = con.prepareStatement("UPDATE MAINTAINANCE SET GENERAL=?,WATER=?,MUNCIPAL=?,CLEAN=?,ELECTRICITY=?,PARKING=?,LIFT=?,TOTAL=? where SCODE=?;");
                stmt2.setInt(1, mba.general);
                stmt2.setInt(2, mba.water);
                stmt2.setInt(3, mba.muncipal);
                stmt2.setInt(4, mba.clean);
                stmt2.setInt(5, mba.electricity);
                stmt2.setInt(6, mba.parking);
                stmt2.setInt(7, mba.lift);
                stmt2.setInt(8, tot);
                stmt2.setString(9, ld.scode);
                stmt2.executeUpdate();
                System.out.println("total=" + tot);
            }
        } catch (Exception e) {
        }
        return "admin/payments";
    }

    @RequestMapping("maintainance_forward")
    public String maintainance_forward(
            @RequestParam("due") String due,
            Model m
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("scode", ld.scode);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM maintainance where scode=?;");
            stmt.setString(1, ld.scode);
            int t = 3800;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                t = rs.getInt("TOTAL");
            }
            System.out.println("totals: " + t);
//PreparedStatement stmt10 = con.prepareStatement("CREATE TABLE "+udm.username+"_"+udm.ascode+"_BILL(ROLETYPE VARCHR(20),SCODE VARCHAR(20),FLATNO VACHAR(20),USERNAME VARCHAR(20),BILLTYPE VARCHAR(30),AMOUNT INT,STATUS VARCHAR(10),DUEDATE VARCHAR(20));");
            PreparedStatement stmt5 = con.prepareStatement("SELECT * FROM USERDETAILS where scode=? and role='Member';");
            stmt5.setString(1, ld.scode);
            String used[]=new String[100];
            String ffl[]=new String[100];
            int i=0;
            ResultSet rs5 = stmt5.executeQuery();
            while (rs5.next()) {
                used[i]=rs5.getString("USERNAME");
                ffl[i]=rs5.getString("Flatno");
                System.out.println(used[i]);
                i++;
            }
            
            PreparedStatement stmt11 = con.prepareStatement("select CURRENT_DATE() as date;");
            String idt=null;
            ResultSet rs11 = stmt11.executeQuery();
            while (rs11.next()) {
                idt=rs11.getString("date");
            }
            
            
            
            
            
            for(int j=0;j<i;j++){
                
                PreparedStatement stmt18 = con.prepareStatement("select * from "+used[j]+"_"+ld.scode+"_BILL  ORDER BY ID DESC LIMIT 1 ");
            int er=0;
            ResultSet rs18 = stmt18.executeQuery();
            while (rs18.next()) {
                er=rs18.getInt("id");
            }
            
            int o=er+1;
                System.out.println("maintainace scode" + ld.scode);
                PreparedStatement stmt1 = con.prepareStatement("INSERT INTO "+used[j]+"_"+ld.scode+"_BILL VALUES(?,?,?,?,?,?,?,?,?,?)");
                System.out.println(used[j]+"_"+ld.scode+"_BILL VALUES");
                stmt1.setInt(1,o);
                stmt1.setString(2, "Member");
                stmt1.setString(3, ld.scode);
                stmt1.setString(4, ffl[j]);
                stmt1.setString(5, used[j]);
                stmt1.setString(6, "maintainance");
                stmt1.setInt(7, t);
                stmt1.setString(8, "UNPAID");
                stmt1.setString(9, idt);
                stmt1.setString(10, due);
                System.out.println("forwarded");
                stmt1.executeUpdate();
            }

          
        } catch (Exception e) {
        }

        return "admin/payments";
    }

    @RequestMapping("/signout")
    public String signout(
            Model m
    ) {
        System.out.println(ud.age + ud.fname + ud.mname);
        return "home";
    }

    @RequestMapping("admin_announcement")
    public String admin_announcement(
            Model m
    ) {
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
        return "admin/announcement";
    }

    @RequestMapping("announced")
    public String announced(
            @RequestParam("sub") String sub,
            @RequestParam("message") String mes,
            Model m
    ) {
        System.out.println("sub:mes " + sub + mes);
        m.addAttribute("un", ld.username);
         m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println("maintainace scode" + ld.scode);

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM announcement where scode=?");
            stmt.setString(1, ld.scode);
            int x = 0;
            String sc=null;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                sc=rs.getString("scode");
                x = rs.getInt("ID");
            }
            System.out.println("sc is "+sc);
            if(sc!=null){
                PreparedStatement stmt1 = con.prepareStatement("UPDATE announcement SET USERNAME=?,SUBJECT=?,MESSAGE=? where scode=?");
                stmt1.setString(1, ld.username);
                stmt1.setString(2, sub);
                stmt1.setString(3, mes);
                stmt1.setString(4, ld.scode);
                stmt1.executeUpdate();
            }
            else{
                
            
            int j = x + 1;

            PreparedStatement stmt1 = con.prepareStatement("INSERT INTO ANNOUNCEMENT VALUES(?,?,?,?,?)");
            stmt1.setInt(1, j);
            stmt1.setString(2, ld.username);
            stmt1.setString(3, sub);
            stmt1.setString(4, mes);
            stmt1.setString(5, ld.scode);
            stmt1.executeUpdate();
            }
        } catch (Exception e) {
        }
        return "admin/announcement";
    }

    @RequestMapping("communityfundadmin")
    public String communityfundadmin(
            Model m,
            @RequestParam("purpose") String pur,
            @RequestParam("amount") int amt
    ) {
        m.addAttribute("un", ld.username);
m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println("maintainace scode" + ld.scode);
            PreparedStatement stmt1 = con.prepareStatement("INSERT INTO COMMUNITY VALUES(?,?,?)");
            stmt1.setString(1, pur);
            stmt1.setInt(2, amt);
            stmt1.setString(3, ld.scode);
            stmt1.executeUpdate();
        } catch (Exception e) {
        }

        return "admin/payments";
    }

    @RequestMapping("admin_complaints")
    public String admin_complaints(
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        return "admin/complaints";
    }

//    MEMBERS DASHBOARD
    @RequestMapping("member_members")
    public String member_members(
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        return "member/members";
    }

    @RequestMapping("member_home")
    public String member_home(
            Model m
    ) {

        System.out.println("username: " + ld.username);
        System.out.println("soced: " + ld.scode);
        System.out.println("pass: " + ld.password);
        m.addAttribute("un", ld.username);
        System.out.println("role: " + ld.role);
        m.addAttribute("user", ld.username);
        m.addAttribute("scode", ld.scode);
        return "member/dashboard";
    }

    @RequestMapping("member_payments")
    public String member_payments(
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        m.addAttribute("flat", ld.flatno);
        return "member/payments";
    }

    @RequestMapping("member_announcement")
    public String member_announcement(
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        return "member/announcement";
    }

    @RequestMapping("member_complaints")
    public String memner_complaint(
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);

        return "member/complaints";
    }

    @RequestMapping("complaintprocess")
    public String complaintprocess(
            @RequestParam("sub") String sub,
            @RequestParam("message") String mes,
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println("maintainace scode" + ld.scode);

            PreparedStatement stmt = con.prepareStatement("SELECT * FROM COMPLAINTS ORDER BY ID DESC LIMIT 1");
            int x = 0;
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {

                x = rs.getInt("ID");
            }
            int j = x + 1;

            PreparedStatement stmt1 = con.prepareStatement("INSERT INTO COMPLAINTS VALUES(?,?,?,?,?,?)");

            stmt1.setInt(1, j);
            stmt1.setString(2, ld.username);
            stmt1.setString(3, sub);
            stmt1.setString(4, mes);
            stmt1.setString(5, ld.scode);
            stmt1.setString(6, ld.flatno);
            stmt1.executeUpdate();
        } catch (Exception e) {
        }
        return "member/complaints";
    }

    @RequestMapping("delete_complaint")
    public String delete_complain(
            @RequestParam("id") int l,
            Model m
    ) {
        m.addAttribute("scode", ld.scode);
        m.addAttribute("un", ld.username);
        m.addAttribute("user", ld.username);
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            System.out.println("maintainace scode" + ld.scode + l);
            PreparedStatement stmt1 = con.prepareStatement("DELETE FROM COMPLAINTS WHERE ID=?");
            stmt1.setInt(1, l);
            stmt1.executeUpdate();
        } catch (Exception e) {
        }
        return "member/complaints";
    }    

    @RequestMapping("Delete_account")
    public String deleteacc(
        @RequestParam("user") String user,
        @RequestParam("scode") String sc
    ){
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HMS?characterEncoding=utf8", "root", "root");
            PreparedStatement stmt1 = con.prepareStatement("DELETE FROM userdetails WHERE scode=? and username=?");
            stmt1.setString(1, sc);
            stmt1.setString(2, user);
            stmt1.executeUpdate();
            
            
            PreparedStatement stmt3 = con.prepareStatement("DROP TABLE "+user+"_"+sc+"_BILL");
            stmt3.executeUpdate();
        } catch (Exception e) {
        }
        return "home";
    }
}
