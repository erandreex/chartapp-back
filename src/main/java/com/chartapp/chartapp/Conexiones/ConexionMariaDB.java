package com.chartapp.chartapp.Conexiones;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMariaDB {

    @SuppressWarnings("finally")
    public static Connection getConexion() {
        Connection con = null;

        String servidor = "localhost";
        String usuario = "root";
        String password = "taliTakumi514";
        String puerto = "3306";
        String db = "admin";

        try {
            String url = "jdbc:mariadb://" + servidor + ":" + puerto + "/" + db;
            con = DriverManager.getConnection(url, usuario, password);
        } catch (SQLException e) {
            con = null;
        } catch (Exception ex) {
            con = null;
        } finally {
            return con;
        }
    }

}
