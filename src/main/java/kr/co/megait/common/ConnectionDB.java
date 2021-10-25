package kr.co.megait.common;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDB {

	
	 private Connection conn;
	
	 private LocalValue LV = new LocalValue();
	
	public ConnectionDB() {
	}
	
	public Connection YesConnectionDB() {
		
		try {
			
			
			String url = "jdbc:mariadb://localhost:3306/" +LV.DB_NAME+"?autoReconnect=true&useSSL=false";
			String id =LV.DB_ID;
			String pw =LV.DB_PWD;
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(url,id,pw);
		}catch(Exception e) {
			
		}
		
		
		return conn;
	}
}
