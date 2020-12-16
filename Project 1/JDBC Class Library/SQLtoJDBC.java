//Credit goes to htorun on Github for the DBTablePrinter.java utility class.
//Using mssql-jdbc-7.0.0.jre8.jar
import javax.swing.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
import java.io.*;
import java.lang.StringBuilder;


public class SQLtoJDBC {
	
	String connectionUrl = null;
	String server = null;
	String port = null;
	String database = null;
	String user = null;
	String password = null;
	String query = null;
	ResultSet resultSet = null;
	StringBuilder url = new StringBuilder();
	
	public SQLtoJDBC()
	{
		connectionUrl = null;
		database = null;
		user = null;
		password = null;
		query = null;
	}
	
	public SQLtoJDBC (String server, String port, String database, String user, String password)
	{
		url.append("jdbc:sqlserver://");
		url.append(server);
		url.append(":");
		url.append(port);
		url.append(";");
		url.append("database=");
		url.append(database);
		url.append(";");
		url.append("user=");
		url.append(user);
		url.append(";");
		url.append("password=");
		url.append(password);
		url.append(";");
		url.append("encrypt=false;");
		url.append("trustServerCertificate=false;");
		url.append("hostNameInCertificate=*.database.windows.net;");
		url.append("loginTimeout=30;");
		connectionUrl = url.toString();
	}
	
	//add function to store procedure
	/*
	void storeProcedure (String query)
	{
		try (Connection connection = DriverManager.getConnection(connectionUrl);
		Statement statement = connection.createStatement();) 		
		{
		   String SQL = query;
		   statement = connection.prepareCall (SQL);
		}
		
		catch (SQLException e) 
		{
		e.printStackTrace();
		}
		
	}
	*/
	
	void execute (String query)
	{
		try (Connection connection = DriverManager.getConnection(connectionUrl);
		PreparedStatement statement = connection.prepareStatement(query);) 
		{
			statement.executeQuery();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
	}
	
	String printResult (String query)
	{
		try (Connection connection = DriverManager.getConnection(connectionUrl);
				PreparedStatement statement = connection.prepareStatement(query);) 
		{
			resultSet = statement.executeQuery();
			DBTablePrinter.printResultSet(resultSet);
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return query;
	}
	
	
	
	public static void main(String[] args) throws IOException {
		
		String server = null;
		String port = null;
		String database = null;
		String user = null;
		String password = null;
		String query = null;
		String choice = null;
	
		Scanner sc = new Scanner(new File("input.txt"));
		String input = "";
		while (sc.hasNextLine()) {
		    input += sc.nextLine()+"\n";
		}
		sc.close();
		
		query = input;
		
		
		server = JOptionPane.showInputDialog("Enter server");
		port = JOptionPane.showInputDialog("Enter port");
		database = JOptionPane.showInputDialog("Enter database");
		user = JOptionPane.showInputDialog("Enter user");
		password = JOptionPane.showInputDialog("Enter password");
		
		SQLtoJDBC newConnect = new SQLtoJDBC(server, port, database, user, password);
		
			
		choice = JOptionPane.showInputDialog("Execute (Type execute) or Print (Type print)?");
		if (choice.equals("execute"))
		{
			newConnect.execute(query);
			JOptionPane.showMessageDialog(null, "If query was correct, it has been executed.");
		}
		
		if (choice.equals("print"))
		{
			newConnect.printResult(query);
			JOptionPane.showMessageDialog(null, "If query was correct, output is in output.txt in the same directory.");
		}
	};
}
