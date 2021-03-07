package shoppingTeam;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.InvalidParameterSpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

public class DB {
	static Connection con = null;
	static Statement stmt = null;
	static PreparedStatement preStmt = null;
	static ResultSet rs = null;
	static String key = "secret key";

	// db ���� �޼ҵ�
	public static void getConnection() {
		String server = "127.0.0.1";

		String database = "shop";
		String username = "root";
		String password = "onlyroot";

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("jdbc ����̹� �ε� ����: " + e.getMessage());
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://" + server + "/" + database + "?characterEncoding=euckr",
					username, password);

		} catch (SQLException ex) {
			System.err.println("jdbc ���� ����: " + ex.getMessage());
			ex.printStackTrace();
		}
	}

	// select���� �����Ͽ� resultset�� ��ȯ�ϴ� �޼ҵ�
	public static ResultSet selectQuery(String sql) {
		try {
			// Statement ����
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

		} catch (SQLException ex) {
			System.err.println("** SQL exec error in selectQuery() : " + ex.getMessage());
		}

		return rs;

	}

	// ����ó���� ���� �������� ���� ������ üũ�ϱ� ���� �޼ҵ�
	public static boolean checkQuery(String sql) {
		boolean check = false;

		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next()) // �����Ͱ� ������
				check = true;

		} catch (SQLException e) {
			System.out.println("checkQuery ����: " + e.getMessage());
		}

		return check;
	}

	// insert ������ �������ִ� �޼ҵ�
	public static int insertQuery(String sql) {

		try {
			stmt = con.createStatement();
			return stmt.executeUpdate(sql);

		} catch (SQLException ex) {
			System.err.println("insertQuery ����: " + ex.getMessage());
			ex.printStackTrace();
		}

		return 0;
	}

	// update ������ �������ִ� �޼ҵ�
	public static int updateQuery(String sql) {
		int count;

		try {
			// Statement ����
			stmt = con.createStatement();
			count = stmt.executeUpdate(sql);
			return count;

		} catch (SQLException ex) {
			System.err.println("** SQL exec error in updateQuery() : " + ex.getMessage());
			return 0;
		}
	}

	// �α����� ���� �޼ҵ�
	public static boolean loginQuery(String pw, String sql) {
		boolean check = false;
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false��, resultset ��ü�� �����ϰ� ����.
			rs = stmt.getResultSet(); // resultset ��ü�� �޾Ƽ� ResultSet�� �������� rs�� �־���
			int checkID = 0;

			if (rs.next()) // ���� ������
				checkID = 1;

			if (checkID == 1 && pw.equals(AES256.decryptAES256(rs.getString("pw"), key)))// ���̵�� ��й�ȣ�� ��ġ�ϸ�
				check = true;
			else if (checkID == 0) { // ���̵� ��ġ���� ������.
				System.out.println("���̵� ��ġ���� �ʽ��ϴ�.");
				return check;
			} else if (!pw.equals(AES256.decryptAES256(rs.getString("pw"), key))) {// ��й�ȣ�� ��ġ���� ������.
				System.out.println("��й�ȣ�� ��ġ���� �ʽ��ϴ�.");
				return check;
			}

		} catch (SQLException | InvalidKeyException | NoSuchPaddingException | NoSuchAlgorithmException
				| InvalidKeySpecException | InvalidAlgorithmParameterException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("consumerLogin ����: " + e.getMessage());
			e.printStackTrace();
		}
		return check;
	}

	// [ȸ��] �α��� - excute�޼ҵ� ���, select�� �̾Ƽ� ��, ��ȣȭ, ��ȣȭ
	public static boolean consumerLogin(String id, String pw) {

		String sql = "select * from consumer where id='" + id + "'";
		// System.out.println(id);

		return loginQuery(pw, sql);
	}

	// �Ϲ�ȸ������
	public static int insertConsumer(String id, String pw, String name, String age, String gender, String phone) {

		int rstVal = 0;
		try {
			pw = AES256.encryptAES256(pw, key);
			String sql = "insert into consumer values('" + id + "', '" + pw + "', '" + name + "', " + age + ", '"
					+ gender + "', '" + phone + "', 0, 0);";
			stmt = con.createStatement();

			rstVal = stmt.executeUpdate(sql);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rstVal;

	}

	// ȸ�� ���̵� ã��
	public static String findConsumerId(String name, String phoneNum) {

		String sql = "select id from consumer where name='" + name + "' and phone ='" + phoneNum + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false��, resultset ��ü�� �����ϰ� ����.
			rs = stmt.getResultSet(); // resultset ��ü�� �޾Ƽ� ResultSet�� �������� rs�� �־���

			System.out.println(name + phoneNum);
			if (rs.next()) {
				return rs.getString("id");
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	// ȸ�� ��� ã��
	public static String findConsumerPwd(String id, String name) {

		String sql = "select pw from consumer where id='" + id + "' and name ='" + name + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false��, resultset ��ü�� �����ϰ� ����.
			rs = stmt.getResultSet(); // resultset ��ü�� �޾Ƽ� ResultSet�� �������� rs�� �־���

			if (rs.next()) {
				return AES256.decryptAES256(rs.getString("pw"), key);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	// ȸ�� ���� ����
	public static int U_InfoChgConfirm(String id, String pw, String phone) {

		String encrypted = null;

		try {
			encrypted = AES256.encryptAES256(pw, key);
		} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException
				| InvalidParameterSpecException | UnsupportedEncodingException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("�������� ����: " + e.getMessage());
			e.printStackTrace();
		}

		String sql = "update consumer set pw='" + encrypted + "', phone='" + phone + "' where id='" + id + "';";

		return updateQuery(sql);
	}

	// ��� ���Ϸ��� �޼ҵ�, �ϴ� ���׽��ϴ�.
	public static ResultSet selectUserBuyBD(String id) {

		String sql = "select bcode, name, bnum, buyprice,  bday, state from buy, product where buy.pcode=product.pcode and id ='"
				+ id + "';";

		return selectQuery(sql);
	}

	// ���� ���� ��ǰ�� �̾ƿ��� �޼ҵ�
	public static ResultSet selectCancelBuy(String id) {
		String sql = "select bcode, name, bnum, buyprice,  bday, state from buy, product where buy.pcode=product.pcode and id ='"
				+ id + "' and state='��� ��';";

		return selectQuery(sql);

	}

	// ȸ�� - ���� ��ҽ� buy ���̺��� bnum���� 0���� �˻�
	public static boolean checkZeroProduct() {
		boolean check = false;

		String sql = "select bnum from buy where bnum = 0;";
		try {
			rs = selectQuery(sql);

			if (rs.next())
				check = true;

		} catch (SQLException e) {
			System.out.println("checkZeroProduct ����: " + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// ȸ�� - �α����� ȸ���� ���� ��ǰ�� ����ϴ� ��츦 �˻��ϴ� �޼ҵ�
	public static int checkExistsCBuy(int bcode) {
		int check = 0;
		String sql = "select bcode from cbuy where bcode = '" + bcode + "';";

		try {
			rs = selectQuery(sql);

			if (rs.next())
				check = 1;

		} catch (SQLException e) {
			System.out.println("checkExistsCBuy ���� :" + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// ȸ�� - preparedStatement�� executeUpdate �޼ҵ带 ���, bcode�� cnum�� ���� �޾� buy���̺���
	// bnum���� ������Ʈ
	public static int minusBnum(int bcode, int cnum) {
		int check = 0;

		try {
			preStmt = con.prepareStatement("update buy set bnum = bnum - ? where bcode = ?;");
			preStmt.setInt(1, cnum);
			preStmt.setInt(2, bcode);

			check = preStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("minusBnum ����" + e.getMessage());
			e.printStackTrace();
		}
		return check;
	}

	public static int minusBuyPrice(int bcode, int cPrice) {
		int check = 0;

		try {
			preStmt = con.prepareStatement("update buy set buyPrice = buyPrice - ? where bcode = ?;");
			preStmt.setInt(1, cPrice);
			preStmt.setInt(2, bcode);

			check = preStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("minusBuyPrice ����" + e.getMessage());
			e.printStackTrace();
		}
		return check;
	}

	// ȸ�� - ���� ��ҽ�, checkExistsCBuy �޼ҵ��� ��ȯ���� �̿��Ͽ� ���� �̹� ��� ������ ������ update, �ƴ϶��
	// insert�� ������ cbuy ���̺� ���� �־���
	public static int insertCBuy(String id, String pcode, int bcode, int cnum) {
		int cnt = 0;

		int check = checkExistsCBuy(bcode);

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(time.format(date));

		try {
			stmt = con.createStatement();

			if (check == 1)
				cnt = stmt.executeUpdate("update cbuy set cnum = cnum +" + cnum + " where bcode=" + bcode + ";");
			else
				cnt = stmt.executeUpdate("insert into cbuy (id,pcode,bcode,cday,cnum) values('" + id + "', '" + pcode
						+ "', " + bcode + ", '" + time.format(date) + "', " + cnum + ");");

		} catch (SQLException ex) {
			System.err.println("insertCBuy ����: " + ex.getMessage());
			ex.printStackTrace();
		}

		return cnt;
	}

	// ȸ�� - checkZeroProduct�� ���� �޾� ���� buy ���̺� bnum�� ���� 0�̶�� �� Ʃ���� ����
	public static boolean deleteZeroProduct() {
		boolean check = false;

		try {
			stmt = con.createStatement();
			if (check = checkZeroProduct())
				stmt.executeUpdate("delete from buy where bnum = 0;");

		} catch (SQLException e) {
			System.out.println("deleteZeroProduct ����: " + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// buy ���̺��� bcode�� pcode�˻��ؼ� ��ȯ
	public static String getPcode(int bcode) {
		String pcode = null;
		try {
			String sql = "select pcode from buy where bcode=" + bcode + ";";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next())
				pcode = rs.getString("pcode");

		} catch (SQLException e) {
			System.err.println(" getPcode ����:" + e.getMessage());
			e.printStackTrace();
		}
		return pcode;
	}

	public static int plusAccount(String id, int acc) {

		String sql = "update consumer set account = account+" + acc + " where id='" + id + "';";

		return updateQuery(sql);
	}

	// (���Ű��� + ����) - ��ǰ ���� ��ҽ� product ���̺��� ��� ���� update����
	public static int plusStock(String pname, int cnum) {
		int cnt = 0;

		try {
			stmt = con.createStatement();
			cnt = stmt.executeUpdate("update product set stock=stock+" + cnum + " where name='" + pname + "';");

		} catch (SQLException ex) {
			System.err.println("plusStock ����: " + ex.getMessage());
			ex.printStackTrace();
		}

		return cnt;
	}

	// [������] �α��� - excute�޼ҵ� ���, select�� �̾Ƽ� ��, ��ȣȭ, ��ȣȭ
	public static boolean managerLogin(String id, String pw) {

		String sql = "select * from manager where id='" + id + "'";
		// System.out.println(id);

		return loginQuery(pw, sql);
	}

	// ��¥�� ���� �����Ȳ ��ȸ
	public static ResultSet selectBuyState(String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select bcode, product.name, id, bnum, (bnum*price), bday, state from buy, product "
					+ "where state = '" + "��� ��" + "' and product.pcode=buy.pcode and bday between '" + between_A
					+ "' and '" + between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select bcode, product.name, id, bnum, (bnum*price), bday, state from buy, product "
					+ "where state = '" + "��� ��" + "'and  product.pcode=buy.pcode;";

		return selectQuery(sql);
	}

	// ��� ���� ����
	public static int updateState(String bcode, String state) {
		String sql = "update buy set state = '" + state + "' where bcode='" + bcode + "';";

		return updateQuery(sql);
	}

	// ȸ�� ���� ��� Ȯ��
	public static ResultSet selectBuyStateUser(String id, String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select bcode, product.name, bnum, (bnum*price), bday, state from buy, product " + "where id = '" + id
					+ "'and state = '" + "��� ��" + "' and product.pcode=buy.pcode and bday between '" + between_A + "' and '"
					+ between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select bcode, product.name, bnum, (bnum*price), bday, state from buy, product " + "where id = '" + id
					+ "' and state = '" + "��� ��" + "'and product.pcode=buy.pcode;";

		return selectQuery(sql);
	}

	// ������ ȸ������
	public static int insertManager(String id, String pw, String phone, String name, String age, String gender) {
		int rstVal = 0;

		try {
			pw = AES256.encryptAES256(pw, key);
			System.out.println(pw);
			String sql = "insert into manager values('" + id + "', '" + pw + "', '" + phone + "', '" + name + "', "
					+ age + ", '" + gender + "');";
			stmt = con.createStatement();

			rstVal = stmt.executeUpdate(sql);
			System.out.println(rstVal);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return rstVal;

	}

	// ������ ���̵� ã��
	public static String findManagerId(String name, String phoneNum) {

		String sql = "select id from manager where name='" + name + "' and phone ='" + phoneNum + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false��, resultset ��ü�� �����ϰ� ����.
			rs = stmt.getResultSet(); // resultset ��ü�� �޾Ƽ� ResultSet�� �������� rs�� �־���

			System.out.println(name + phoneNum);
			if (rs.next()) {
				return rs.getString("id");
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	// ������ ��� ã��
	public static String findManagerPwd(String id, String name) {

		String sql = "select pw from manager where id='" + id + "' and name ='" + name + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false��, resultset ��ü�� �����ϰ� ����.
			rs = stmt.getResultSet(); // resultset ��ü�� �޾Ƽ� ResultSet�� �������� rs�� �־���

			if (rs.next()) {
				return AES256.decryptAES256(rs.getString("pw"), key);
			} else {
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";

	}

	// ������ ��������?
	public static int M_InfoChgConfirm(String id, String passwd, String phone) {

		String encrypted = null;

		try {
			encrypted = AES256.encryptAES256(passwd, key);
		} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException
				| InvalidParameterSpecException | UnsupportedEncodingException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("�������� ����: " + e.getMessage());
			e.printStackTrace();
		}

		String sql = "update manager set pw='" + encrypted + "', phone='" + phone + "' where id = '" + id + "';";

		return updateQuery(sql);
	}

	public static ResultSet selectDeliveryStatus(String state, String date1, String date2) {
		String sql = null;

		if (state.equals("��ü") && date1 == null && date2 == null)
			sql = "select bday, id, name, state from buy, product where buy.pcode=product.pcode;";
		else if (state.equals("��ü") && date1 != null && date2 != null)
			sql = "select bday, id, name, state from buy, product where buy.pcode=product.pcode and bday between '"
					+ date1 + "' and '" + date2 + "';";
		else
			sql = "select bday, id, name, state from buy, product where buy.pcode=product.pcode and bday between '"
					+ date1 + "' and '" + date2 + "' and state='" + state + "';";

		return selectQuery(sql);
	}

	public static ResultSet selectMinStock() {

		String sql = "select name,stock,price from product where stock <= (minst + 5);";

		return selectQuery(sql);

	}

	public static ResultSet addStockList(String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select ascode,id,product.pcode,name,addnum,adate from product,addstock "
					+ "where product.pcode=addstock.pcode and adate between '" + between_A + "' and '" + between_B
					+ "';";
		else if (between_A == null && between_B == null)
			sql = "select ascode,id,product.pcode,name,addnum,adate from product,addstock where product.pcode=addstock.pcode;";

		return selectQuery(sql);

	}

	public static ResultSet addProductList(String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select id,product.pcode,name,adate from addp,product "
					+ "where product.pcode=addp.pcode and adate between '" + between_A + "' and '" + between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select id,product.pcode,name,adate from addp,product where product.pcode=addp.pcode;";

		return selectQuery(sql);

	}

	public static ResultSet addCancelBuyList(String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select bcode,id,product.pcode,name,cday,cnum from cbuy,product "
					+ "where product.pcode=cbuy.pcode and cday between '" + between_A + "' and '" + between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select bcode,id,product.pcode,name,cday,cnum from cbuy,product where product.pcode=cbuy.pcode;";

		return selectQuery(sql);

	}

	public static ResultSet salesStatement(String between_A, String between_B) {
		String sql = null;
		if (between_A != null && between_B != null)
			sql = "select bday, buy.pcode as code, name, sum(bnum) as nums, (sum(bnum)*price) as buyPrice from buy,product "
					+ "where product.pcode=buy.pcode and bday between '" + between_A + "' and '" + between_B
					+ "' group by bday, buy.pcode order by bday, buy.pcode;";
		else if (between_A == null && between_B == null)
			sql = "select bday, buy.pcode as code, name, sum(bnum) as nums, (sum(bnum)*price) as buyPrice "
					+ "from buy,product where product.pcode=buy.pcode group by bday, buy.pcode order by bday, buy.pcode";

		return selectQuery(sql);

	}

	public static int updateProductOfStock(String pname, int add_num) {
		String sql = "update product set stock=stock+" + add_num + " where name='" + pname + "';";

		return updateQuery(sql);
	}

	public static int insertAddStock(String id, String pcode, int add_num) {

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		String sql = "insert into addstock (id,adate,pcode,addnum) values('" + id + "', '" + time.format(date) + "', '"
				+ pcode + "', " + add_num + ");";

		return updateQuery(sql);
	}

	// ������ �޴� - ��ǰ �߰�: product���̺� ���� �־���
	public static int insertProduct(String pcode, String name, int price, int stock, int minst) {
		String sql = null;

		sql = "insert into product values('" + pcode + "', '" + name + "', " + price + ", " + stock + ", " + minst
				+ ");";

		return insertQuery(sql);
	}

	// ������ �޴� - ��ǰ �߰� ���� ���̺�(addp)�� ���� �־���
	public static int insertAddP(String id, String pcode) {
		String sql = null;
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		sql = "insert into addp values('" + id + "', '" + time.format(date) + "', '" + pcode + "');";

		return insertQuery(sql);
	}

	// ������ �޴� - ��ǰ �߰��� �ڵ� üũ(���� ó��)
	public static boolean checkPcode(String pcode) {
		String sql = null;

		sql = "select pcode from product where pcode='" + pcode + "';";

		return checkQuery(sql);
	}

	// ������ �޴� - ��ǰ �߰��� ��ǰ�� üũ(���� ó��)
	public static boolean checkPname(String pname) {
		String sql = null;

		sql = "select name from product where name='" + pname + "';";

		return checkQuery(sql);
	}

	// ��ǰ �ڵ� ����
	public static String getPcode(String pname) {
		String pcode = null;

		try {
			String sql = "select pcode from product where name='" + pname + "';";

			rs = selectQuery(sql);

			if (rs.next())
				pcode = rs.getString("pcode");

		} catch (SQLException e) {
			System.err.println("getPcode ����:" + e.getMessage());
			e.printStackTrace();
		}

		return pcode;
	}

	// product���̺��� pcode�� pname�� ���Ͽ� ��ȯ
	public static String getPname(String pcode) {
		String pname = null;
		try {
			String sql = "select name from product where pcode='" + pcode + "';";

			rs = selectQuery(sql);

			if (rs.next())
				pname = rs.getString("name");

		} catch (SQLException e) {
			System.err.println("getPname ����:" + e.getMessage());
			e.printStackTrace();
		}

		System.out.println(pname);
		return pname;
	}

	public static ResultSet selectBProduct(String pname) {
		String sql = "select pcode, name, price, stock from product where name='" + pname + "';";

		return selectQuery(sql);
	}

	public static int minusStock(String pname, int bnum) {
		String sql = "update product set stock=stock-" + bnum + " where name='" + pname + "';";

		return updateQuery(sql);
	}

	public static int buyRecord(String id, String pcode, int bnum) {
		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		String sql = "insert into buy (id,pcode,bday,bnum,state) values('" + id + "', '" + pcode + "', '"
				+ time.format(date) + "', '" + bnum + "', '��� ��');";

		return updateQuery(sql);
	}

	public static int buyProduct(String id, int buyPrice, int point) {
		String sql = null;

		if (point == 0)
			sql = "update consumer set account=account-" + buyPrice + ", point=point+" + (buyPrice * 0.03)
					+ " where id='" + id + "';";
		else if (point != 0)
			sql = "update consumer set account=account-" + (buyPrice - point) + ", point=point-" + point + " where id='"
					+ id + "';";

		return updateQuery(sql);
	}

	public static int buyRecord(String id, String pcode, int bnum, int buyPrice) {
		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		String sql = "insert into buy (id,pcode,bday,bnum,buyprice,state) values('" + id + "', '" + pcode + "', '"
				+ time.format(date) + "', '" + bnum + "', " + buyPrice + ", '��� ��');";

		return updateQuery(sql);
	}

	public static int sending(String id) {
		int send_count = 0;

		try {
			String sql = "select count(state) from buy where id='" + id + "' and state='��� ��';";
			
			rs = selectQuery(sql);

			if (rs.next())
				send_count = rs.getInt("count(state)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return send_count;
	}

	public static int complete(String id) {
		int com_count = 0;

		try {
			String sql = "select count(state) from buy where id='" + id + "' and state='��� �Ϸ�';";
			
			rs = selectQuery(sql);

			if (rs.next())
				com_count = rs.getInt("count(state)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return com_count;
	}

	public static int cancel(String id) {
		int can_count = 0;

		try {
			String sql = "select count(bcode) from cbuy where id='" + id + "';";
			
			rs = selectQuery(sql);

			if (rs.next())
				can_count = rs.getInt("count(bcode)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return can_count;
	}

	public static int mounth(String id) {
		int m_price = 0;

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM");

		try {
			String sql = "select sum(buyprice) from buy where id='" + id + "' and bday like '" + time.format(date)
					+ "-%%';";
			
			rs = selectQuery(sql);

			if (rs.next())
				m_price = rs.getInt("sum(buyprice)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return m_price;
	}

	public static int today(String id) {
		int m_price = 0;

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		try {
			String sql = "select sum(buyprice) from buy where id='" + id + "' and bday like '" + time.format(date)
					+ "';";

			rs = selectQuery(sql);

			if (rs.next())
				m_price = rs.getInt("sum(buyprice)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return m_price;
	}

	public static int mustAdd() {
		int add = 0;

		try {
			String sql = "select count(name) from product where stock <= (minst + 5);";

			rs = selectQuery(sql);

			if (rs.next())
				add = rs.getInt("count(name)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return add;
	}

	public static int pointRecord(String id, String pname, int point, int buyPrice) {
		String sql = null;

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		if (point == 0)
			sql = "insert into point (pdate,id,name,point,state) values('" + time.format(date) + "','" + id + "'" + ",'"
					+ pname + "'," + Math.floor(buyPrice * 0.03) + ",'����');";
		else if (point != 0)
			sql = "insert into point (pdate,id,name,point,state) values('" + time.format(date) + "','" + id + "'" + ",'"
					+ pname + "'," + point + ",'���');";

		return updateQuery(sql);
	}

	// ����ȭ�� ������Ʈ
	public static int updateAccount(int add_account, String id) {
		String sql = "update consumer set account = account + " + add_account + " where id='" + id + "';";

		return updateQuery(sql);
	}

	// ����ȭ�� �ҷ�����
	public static int getAccount(String id) {
		int account = 0;

		try {
			String sql = "select account from consumer where id='" + id + "';";

			rs = selectQuery(sql);

			if (rs.next())

				account = rs.getInt("account");

		} catch (SQLException e) {
			System.err.println("account ����:" + e.getMessage());
			e.printStackTrace();
		}

		return account;
	}

	public static ResultSet selectPointStatus(String id, String state, String date1, String date2) {
		String sql = null;

		if (date1 != null && date2 != null) {
			if (state.equals("��ü"))
				sql = "select pdate, sum(point), state from point where id='" + id + "' and pdate between '" + date1
						+ "' and '" + date2 + "' group by pdate, state order by pdate, state;";
			else
				sql = "select pdate, sum(point), state from point where id='" + id + "' and state='" + state
						+ "' and pdate between '" + date1 + "' and '" + date2
						+ "' group by pdate, state order by pdate, state;";
		} else if (date1 == null && date2 == null) {
			if (state.equals("��ü"))
				sql = "select pdate, sum(point), state from point where id='" + id
						+ "' group by pdate, state order by pdate, state;";
			else
				sql = "select pdate, sum(point), state from point where id='" + id + "' and state='" + state
						+ "' group by pdate, state order by pdate, state;";
		}
		return selectQuery(sql);
	}

	public static int mounth() {
		int m_price = 0;

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM");

		try {
			String sql = "select sum(buyprice) from buy where bday like '" + time.format(date) + "-%%';";

			rs = selectQuery(sql);

			if (rs.next())
				m_price = rs.getInt("sum(buyprice)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return m_price;
	}

	public static int today() {
		int m_price = 0;

		Date date = new Date();

		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		try {
			String sql = "select sum(buyprice) from buy where bday='" + time.format(date) + "';";

			rs = selectQuery(sql);

			if (rs.next())
				m_price = rs.getInt("sum(buyprice)");

		} catch (SQLException e) {
			System.err.println("sending() ����:" + e.getMessage());
			e.printStackTrace();
		}

		return m_price;
	}

	public static ResultSet selectBuy() {
		String sql = "select bcode,buy.pcode,bday,name,bnum,id,state from buy,product where buy.pcode = product.pcode;";

		return selectQuery(sql);
	}

	public static ResultSet selectBuy(String id) {
		String sql = "select buy.pcode, bday, name, bnum, state from buy,product where id ='" + id
				+ "' and buy.pcode = product.pcode;";

		return selectQuery(sql);
	}

	public static ResultSet selectCBuy(String id) {
		String sql = "select cbuy.pcode, cday, name, cnum from cbuy,product where id ='" + id
				+ "' and cbuy.pcode = product.pcode;";

		return selectQuery(sql);
	}

	public static ResultSet selectConsumer(String id) {
		String sql = "select account,point from consumer where id='" + id + "';";
		return selectQuery(sql);
	}

	public static ResultSet searchNameProduct(String pname) {
		String sql = "select pcode, name, price from product where name like '%" + pname + "%';";
		return selectQuery(sql);
	}

	public static ResultSet selectCProduct(String c) {
		String sql = "select pcode, name, price from product where pcode like '" + c + "%';";

		return selectQuery(sql);
	}

	public static void closeConnection() {
		try {
			// ������ �ݴ´�.
			if (stmt != null)
				stmt.close();
			if (preStmt != null)
				preStmt.close();
			if (con != null)
				con.close();
		} catch (SQLException ex) {
		}
		;
	}
}
