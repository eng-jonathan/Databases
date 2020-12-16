
import java.awt.EventQueue;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.border.EmptyBorder;
import net.proteanit.sql.DbUtils;
import java.awt.GridBagLayout;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import java.awt.GridBagConstraints;
import java.awt.Insets;
import javax.swing.JTextField;
import javax.swing.JButton;
import javax.swing.JTextArea;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.File;
import java.io.FileNotFoundException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
import java.awt.Font;
import javax.swing.JTable;

@SuppressWarnings("serial")
public class SQLtoJDBCFrame extends JFrame {

	String connectionUrl = null;
	String server = null;
	String port = null;
	String database = null;
	String user = null;
	String password = null;
	String query = null;
	String input = "";
	ResultSet rs = null;
	StringBuilder url = new StringBuilder();
	SQLtoJDBC newConnect;

	private JPanel contentPane;
	private JTextField serverTextField;
	private JTextField portTextField;
	private JTextField dbTextField;
	private JTextField userTextField;
	private JTextField pwTextField;
	private JTable table;

	public static void main(String[] args) {
		
		
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					SQLtoJDBCFrame frame = new SQLtoJDBCFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}


	public SQLtoJDBCFrame() { 
		
		setTitle("SQLtoJDBC.exe Group 4");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 450, 300);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		setContentPane(contentPane);
		GridBagLayout gbl_contentPane = new GridBagLayout();
		gbl_contentPane.columnWidths = new int[]{0, 0, 0, 0, 0, 0};
		gbl_contentPane.rowHeights = new int[]{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		gbl_contentPane.columnWeights = new double[]{1.0, 0.0, 0.0, 0.0, 1.0, Double.MIN_VALUE};
		gbl_contentPane.rowWeights = new double[]{0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0, 1.0, 1.0, 1.0, Double.MIN_VALUE};
		contentPane.setLayout(gbl_contentPane);

		JLabel lblNewLabel = new JLabel("Server:");
		GridBagConstraints gbc_lblNewLabel = new GridBagConstraints();
		gbc_lblNewLabel.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel.gridx = 0;
		gbc_lblNewLabel.gridy = 0;
		contentPane.add(lblNewLabel, gbc_lblNewLabel);

		serverTextField = new JTextField();
		serverTextField.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_serverTextField = new GridBagConstraints();
		gbc_serverTextField.gridwidth = 4;
		gbc_serverTextField.insets = new Insets(0, 0, 5, 0);
		gbc_serverTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_serverTextField.gridx = 1;
		gbc_serverTextField.gridy = 0;
		contentPane.add(serverTextField, gbc_serverTextField);
		serverTextField.setColumns(10);

		JLabel lblNewLabel_1 = new JLabel("Port:");
		GridBagConstraints gbc_lblNewLabel_1 = new GridBagConstraints();
		gbc_lblNewLabel_1.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel_1.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_1.gridx = 0;
		gbc_lblNewLabel_1.gridy = 1;
		contentPane.add(lblNewLabel_1, gbc_lblNewLabel_1);

		portTextField = new JTextField();
		portTextField.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_portTextField = new GridBagConstraints();
		gbc_portTextField.gridwidth = 4;
		gbc_portTextField.insets = new Insets(0, 0, 5, 0);
		gbc_portTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_portTextField.gridx = 1;
		gbc_portTextField.gridy = 1;
		contentPane.add(portTextField, gbc_portTextField);
		portTextField.setColumns(10);

		JLabel lblNewLabel_2 = new JLabel("Database:");
		GridBagConstraints gbc_lblNewLabel_2 = new GridBagConstraints();
		gbc_lblNewLabel_2.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel_2.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_2.gridx = 0;
		gbc_lblNewLabel_2.gridy = 2;
		contentPane.add(lblNewLabel_2, gbc_lblNewLabel_2);

		dbTextField = new JTextField();
		dbTextField.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_dbTextField = new GridBagConstraints();
		gbc_dbTextField.gridwidth = 4;
		gbc_dbTextField.insets = new Insets(0, 0, 5, 0);
		gbc_dbTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_dbTextField.gridx = 1;
		gbc_dbTextField.gridy = 2;
		contentPane.add(dbTextField, gbc_dbTextField);
		dbTextField.setColumns(10);

		JLabel lblNewLabel_3 = new JLabel("User:");
		GridBagConstraints gbc_lblNewLabel_3 = new GridBagConstraints();
		gbc_lblNewLabel_3.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel_3.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_3.gridx = 0;
		gbc_lblNewLabel_3.gridy = 3;
		contentPane.add(lblNewLabel_3, gbc_lblNewLabel_3);

		userTextField = new JTextField();
		userTextField.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_userTextField = new GridBagConstraints();
		gbc_userTextField.gridwidth = 4;
		gbc_userTextField.insets = new Insets(0, 0, 5, 0);
		gbc_userTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_userTextField.gridx = 1;
		gbc_userTextField.gridy = 3;
		contentPane.add(userTextField, gbc_userTextField);
		userTextField.setColumns(10);

		JLabel lblNewLabel_4 = new JLabel("Password:");
		GridBagConstraints gbc_lblNewLabel_4 = new GridBagConstraints();
		gbc_lblNewLabel_4.anchor = GridBagConstraints.EAST;
		gbc_lblNewLabel_4.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_4.gridx = 0;
		gbc_lblNewLabel_4.gridy = 4;
		contentPane.add(lblNewLabel_4, gbc_lblNewLabel_4);

		pwTextField = new JTextField();
		pwTextField.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_pwTextField = new GridBagConstraints();
		gbc_pwTextField.gridwidth = 4;
		gbc_pwTextField.insets = new Insets(0, 0, 5, 0);
		gbc_pwTextField.fill = GridBagConstraints.HORIZONTAL;
		gbc_pwTextField.gridx = 1;
		gbc_pwTextField.gridy = 4;
		contentPane.add(pwTextField, gbc_pwTextField);
		pwTextField.setColumns(10);

		JButton btnNewButton = new JButton("Connect");
		btnNewButton.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				server = serverTextField.getText();
				port = portTextField.getText();
				database = dbTextField.getText();
				user = userTextField.getText();
				password = pwTextField.getText();
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
				newConnect = new SQLtoJDBC(server, port, database, user, password);
			}
		});


		JLabel lblNewLabel_5 = new JLabel("Input:");
		GridBagConstraints gbc_lblNewLabel_5 = new GridBagConstraints();
		gbc_lblNewLabel_5.anchor = GridBagConstraints.WEST;
		gbc_lblNewLabel_5.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_5.gridx = 0;
		gbc_lblNewLabel_5.gridy = 6;
		contentPane.add(lblNewLabel_5, gbc_lblNewLabel_5);
		
		JTextArea textArea = new JTextArea();
		textArea.setFont(new Font("Courier New", Font.PLAIN, 11));
		GridBagConstraints gbc_textArea = new GridBagConstraints();
		gbc_textArea.gridheight = 2;
		gbc_textArea.insets = new Insets(0, 0, 5, 0);
		gbc_textArea.gridwidth = 5;
		gbc_textArea.fill = GridBagConstraints.BOTH;
		gbc_textArea.gridx = 0;
		gbc_textArea.gridy = 7;
		textArea.setLineWrap(true);
		textArea.setWrapStyleWord(true);
		JScrollPane scrolltxt = new JScrollPane();
		scrolltxt.setViewportView(textArea);
		scrolltxt.setWheelScrollingEnabled(true);
		contentPane.add(scrolltxt, gbc_textArea);
		
		GridBagConstraints gbc_btnNewButton = new GridBagConstraints();
		gbc_btnNewButton.insets = new Insets(0, 0, 5, 5);
		gbc_btnNewButton.gridx = 1;
		gbc_btnNewButton.gridy = 5;
		contentPane.add(btnNewButton, gbc_btnNewButton);

		JButton btnNewButton_1 = new JButton("Execute");
		btnNewButton_1.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				query = textArea.getText();
				newConnect.execute(query);
			}
		});
		
		GridBagConstraints gbc_btnNewButton_1 = new GridBagConstraints();
		gbc_btnNewButton_1.insets = new Insets(0, 0, 5, 5);
		gbc_btnNewButton_1.gridx = 2;
		gbc_btnNewButton_1.gridy = 5;
		contentPane.add(btnNewButton_1, gbc_btnNewButton_1);
		
		table = new JTable();
		GridBagConstraints gbc_table = new GridBagConstraints();
		gbc_table.gridheight = 2;
		gbc_table.gridwidth = 5;
		gbc_table.fill = GridBagConstraints.BOTH;
		gbc_table.gridx = 0;
		gbc_table.gridy = 10;
		JScrollPane scrolltxt2 = new JScrollPane();
		scrolltxt2.setViewportView(table);
		contentPane.add(scrolltxt2, gbc_table);
		
		JButton btnNewButton_2 = new JButton("Execute & Print");
		btnNewButton_2.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				query = textArea.getText();
				newConnect.printResult(query);
				
				try (Connection connection = DriverManager.getConnection(connectionUrl);
						PreparedStatement statement = connection.prepareStatement(query);) 
				{
					rs = statement.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch (SQLException ex) 
				{
					ex.printStackTrace();
				}
				
				
				Scanner sc;
				
				try 
				{
					sc = new Scanner(new File("output.txt"));
					while (sc.hasNextLine()) 
					{
						input += sc.nextLine()+"\n";
					}
					sc.close();
				} 
				
				catch (FileNotFoundException e1) 
				{
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				input = "";
			}
		});
		
		JButton btnNewButton_3 = new JButton("Stored Procedure Execute");
		btnNewButton_3.addMouseListener(new MouseAdapter() {
			@Override
			public void mouseClicked(MouseEvent e) {
				query = textArea.getText();
				newConnect.printResult(query);
				
				try (Connection connection = DriverManager.getConnection(connectionUrl);
						CallableStatement statement = connection.prepareCall(query);) 
				{
					String numParam = JOptionPane.showInputDialog("Enter number of parameters");
					if (Integer.parseInt(numParam) > 1)
					{
						String answerString = JOptionPane.showInputDialog("Enter parameter");
						statement.setString(1, answerString);
						String answerString2 = JOptionPane.showInputDialog("Enter second parameter");
						int answerString2Num = Integer.parseInt(answerString2);
						statement.setInt(2, answerString2Num);
					}
					
					if (Integer.parseInt(numParam) == 1)
					{
						String answerString = JOptionPane.showInputDialog("Enter parameter");
						int answerStringNum = Integer.parseInt(answerString);
						statement.setInt(1, answerStringNum);
						
					}

					rs = statement.executeQuery();
					table.setModel(DbUtils.resultSetToTableModel(rs));
				}
				catch (SQLException ex) 
				{
					ex.printStackTrace();
				}
				
				
				Scanner sc;
				
				try 
				{
					sc = new Scanner(new File("output.txt"));
					while (sc.hasNextLine()) 
					{
						input += sc.nextLine()+"\n";
					}
					sc.close();
				} 
				
				catch (FileNotFoundException e1) 
				{
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				
				input = "";
			}
		});
		
		GridBagConstraints gbc_btnNewButton_3 = new GridBagConstraints();
		gbc_btnNewButton_3.insets = new Insets(0, 0, 5, 0);
		gbc_btnNewButton_3.gridx = 4;
		gbc_btnNewButton_3.gridy = 5;
		contentPane.add(btnNewButton_3, gbc_btnNewButton_3);

		GridBagConstraints gbc_btnNewButton_2 = new GridBagConstraints();
		gbc_btnNewButton_2.insets = new Insets(0, 0, 5, 5);
		gbc_btnNewButton_2.gridx = 3;
		gbc_btnNewButton_2.gridy = 5;
		contentPane.add(btnNewButton_2, gbc_btnNewButton_2);
		
		JLabel lblNewLabel_6 = new JLabel("Output: ");
		GridBagConstraints gbc_lblNewLabel_6 = new GridBagConstraints();
		gbc_lblNewLabel_6.fill = GridBagConstraints.VERTICAL;
		gbc_lblNewLabel_6.anchor = GridBagConstraints.WEST;
		gbc_lblNewLabel_6.insets = new Insets(0, 0, 5, 5);
		gbc_lblNewLabel_6.gridx = 0;
		gbc_lblNewLabel_6.gridy = 9;
		contentPane.add(lblNewLabel_6, gbc_lblNewLabel_6);

	}

}
