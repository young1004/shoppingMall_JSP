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

	// db 연결 메소드
	public static void getConnection() {
		String server = "127.0.0.1";

		String database = "shop";
		String username = "root";
		String password = "onlyroot";

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("jdbc 드라이버 로딩 오류: " + e.getMessage());
			e.printStackTrace();
		}

		try {
			con = DriverManager.getConnection("jdbc:mysql://" + server + "/" + database + "?characterEncoding=euckr",
					username, password);

		} catch (SQLException ex) {
			System.err.println("jdbc 연결 오류: " + ex.getMessage());
			ex.printStackTrace();
		}
	}

	// select문을 실행하여 resultset을 반환하는 메소드
	public static ResultSet selectQuery(String sql) {
		try {
			// Statement 생성
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

		} catch (SQLException ex) {
			System.err.println("** SQL exec error in selectQuery() : " + ex.getMessage());
		}

		return rs;

	}

	// 예외처리를 위해 데이터의 존재 유무를 체크하기 위한 메소드
	public static boolean checkQuery(String sql) {
		boolean check = false;

		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next()) // 데이터가 있으면
				check = true;

		} catch (SQLException e) {
			System.out.println("checkQuery 오류: " + e.getMessage());
		}

		return check;
	}

	// insert 구문을 실행해주는 메소드
	public static int insertQuery(String sql) {

		try {
			stmt = con.createStatement();
			return stmt.executeUpdate(sql);

		} catch (SQLException ex) {
			System.err.println("insertQuery 오류: " + ex.getMessage());
			ex.printStackTrace();
		}

		return 0;
	}

	// update 구문을 실행해주는 메소드
	public static int updateQuery(String sql) {
		int count;

		try {
			// Statement 생성
			stmt = con.createStatement();
			count = stmt.executeUpdate(sql);
			return count;

		} catch (SQLException ex) {
			System.err.println("** SQL exec error in updateQuery() : " + ex.getMessage());
			return 0;
		}
	}

	// 로그인을 위한 메소드
	public static boolean loginQuery(String pw, String sql) {
		boolean check = false;
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false값, resultset 객체를 저장하고 있음.
			rs = stmt.getResultSet(); // resultset 객체를 받아서 ResultSet의 참조변수 rs에 넣어줌
			int checkID = 0;

			if (rs.next()) // 값이 있으면
				checkID = 1;

			if (checkID == 1 && pw.equals(AES256.decryptAES256(rs.getString("pw"), key)))// 아이디와 비밀번호가 일치하면
				check = true;
			else if (checkID == 0) { // 아이디가 일치하지 않으면.
				System.out.println("아이디가 일치하지 않습니다.");
				return check;
			} else if (!pw.equals(AES256.decryptAES256(rs.getString("pw"), key))) {// 비밀번호가 일치하지 않으면.
				System.out.println("비밀번호가 일치하지 않습니다.");
				return check;
			}

		} catch (SQLException | InvalidKeyException | NoSuchPaddingException | NoSuchAlgorithmException
				| InvalidKeySpecException | InvalidAlgorithmParameterException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("consumerLogin 오류: " + e.getMessage());
			e.printStackTrace();
		}
		return check;
	}

	// [회원] 로그인 - excute메소드 사용, select로 뽑아서 비교, 암호화, 복호화
	public static boolean consumerLogin(String id, String pw) {

		String sql = "select * from consumer where id='" + id + "'";
		// System.out.println(id);

		return loginQuery(pw, sql);
	}

	// 일반회원가입
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

	// 회원 아이디 찾기
	public static String findConsumerId(String name, String phoneNum) {

		String sql = "select id from consumer where name='" + name + "' and phone ='" + phoneNum + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false값, resultset 객체를 저장하고 있음.
			rs = stmt.getResultSet(); // resultset 객체를 받아서 ResultSet의 참조변수 rs에 넣어줌

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

	// 회원 비번 찾기
	public static String findConsumerPwd(String id, String name) {

		String sql = "select pw from consumer where id='" + id + "' and name ='" + name + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false값, resultset 객체를 저장하고 있음.
			rs = stmt.getResultSet(); // resultset 객체를 받아서 ResultSet의 참조변수 rs에 넣어줌

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

	// 회원 정보 수정
	public static int U_InfoChgConfirm(String id, String pw, String phone) {

		String encrypted = null;

		try {
			encrypted = AES256.encryptAES256(pw, key);
		} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException
				| InvalidParameterSpecException | UnsupportedEncodingException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("정보수정 오류: " + e.getMessage());
			e.printStackTrace();
		}

		String sql = "update consumer set pw='" + encrypted + "', phone='" + phone + "' where id='" + id + "';";

		return updateQuery(sql);
	}

	// 사용 안하려는 메소드, 일단 놔뒀습니다.
	public static ResultSet selectUserBuyBD(String id) {

		String sql = "select bcode, name, bnum, buyprice,  bday, state from buy, product where buy.pcode=product.pcode and id ='"
				+ id + "';";

		return selectQuery(sql);
	}

	// 구매 전인 물품을 뽑아오는 메소드
	public static ResultSet selectCancelBuy(String id) {
		String sql = "select bcode, name, bnum, buyprice,  bday, state from buy, product where buy.pcode=product.pcode and id ='"
				+ id + "' and state='배송 전';";

		return selectQuery(sql);

	}

	// 회원 - 구매 취소시 buy 테이블의 bnum값이 0인지 검사
	public static boolean checkZeroProduct() {
		boolean check = false;

		String sql = "select bnum from buy where bnum = 0;";
		try {
			rs = selectQuery(sql);

			if (rs.next())
				check = true;

		} catch (SQLException e) {
			System.out.println("checkZeroProduct 오류: " + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// 회원 - 로그인한 회원이 같은 물품을 취소하는 경우를 검사하는 메소드
	public static int checkExistsCBuy(int bcode) {
		int check = 0;
		String sql = "select bcode from cbuy where bcode = '" + bcode + "';";

		try {
			rs = selectQuery(sql);

			if (rs.next())
				check = 1;

		} catch (SQLException e) {
			System.out.println("checkExistsCBuy 오류 :" + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// 회원 - preparedStatement의 executeUpdate 메소드를 사용, bcode와 cnum의 값을 받아 buy테이블의
	// bnum값을 업데이트
	public static int minusBnum(int bcode, int cnum) {
		int check = 0;

		try {
			preStmt = con.prepareStatement("update buy set bnum = bnum - ? where bcode = ?;");
			preStmt.setInt(1, cnum);
			preStmt.setInt(2, bcode);

			check = preStmt.executeUpdate();

		} catch (SQLException e) {
			System.err.println("minusBnum 오류" + e.getMessage());
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
			System.err.println("minusBuyPrice 오류" + e.getMessage());
			e.printStackTrace();
		}
		return check;
	}

	// 회원 - 구매 취소시, checkExistsCBuy 메소드의 반환값을 이용하여 만약 이미 취소 내역이 있으면 update, 아니라면
	// insert로 나눠서 cbuy 테이블에 값을 넣어줌
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
			System.err.println("insertCBuy 오류: " + ex.getMessage());
			ex.printStackTrace();
		}

		return cnt;
	}

	// 회원 - checkZeroProduct의 값을 받아 만약 buy 테이블에 bnum의 값이 0이라면 그 튜플을 삭제
	public static boolean deleteZeroProduct() {
		boolean check = false;

		try {
			stmt = con.createStatement();
			if (check = checkZeroProduct())
				stmt.executeUpdate("delete from buy where bnum = 0;");

		} catch (SQLException e) {
			System.out.println("deleteZeroProduct 오류: " + e.getMessage());
			e.printStackTrace();
		}

		return check;
	}

	// buy 테이블의 bcode로 pcode검색해서 반환
	public static String getPcode(int bcode) {
		String pcode = null;
		try {
			String sql = "select pcode from buy where bcode=" + bcode + ";";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			if (rs.next())
				pcode = rs.getString("pcode");

		} catch (SQLException e) {
			System.err.println(" getPcode 오류:" + e.getMessage());
			e.printStackTrace();
		}
		return pcode;
	}

	public static int plusAccount(String id, int acc) {

		String sql = "update consumer set account = account+" + acc + " where id='" + id + "';";

		return updateQuery(sql);
	}

	// (구매개수 + 재고수) - 제품 구매 취소시 product 테이블의 재고 값을 update해줌
	public static int plusStock(String pname, int cnum) {
		int cnt = 0;

		try {
			stmt = con.createStatement();
			cnt = stmt.executeUpdate("update product set stock=stock+" + cnum + " where name='" + pname + "';");

		} catch (SQLException ex) {
			System.err.println("plusStock 오류: " + ex.getMessage());
			ex.printStackTrace();
		}

		return cnt;
	}

	// [관리자] 로그인 - excute메소드 사용, select로 뽑아서 비교, 암호화, 복호화
	public static boolean managerLogin(String id, String pw) {

		String sql = "select * from manager where id='" + id + "'";
		// System.out.println(id);

		return loginQuery(pw, sql);
	}

	// 날짜에 따른 배송현황 조회
	public static ResultSet selectBuyState(String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select bcode, product.name, id, bnum, (bnum*price), bday, state from buy, product "
					+ "where state = '" + "배송 전" + "' and product.pcode=buy.pcode and bday between '" + between_A
					+ "' and '" + between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select bcode, product.name, id, bnum, (bnum*price), bday, state from buy, product "
					+ "where state = '" + "배송 전" + "'and  product.pcode=buy.pcode;";

		return selectQuery(sql);
	}

	// 배송 상태 변경
	public static int updateState(String bcode, String state) {
		String sql = "update buy set state = '" + state + "' where bcode='" + bcode + "';";

		return updateQuery(sql);
	}

	// 회원 구매 목록 확인
	public static ResultSet selectBuyStateUser(String id, String between_A, String between_B) {
		String sql = null;

		if (between_A != null && between_B != null)
			sql = "select bcode, product.name, bnum, (bnum*price), bday, state from buy, product " + "where id = '" + id
					+ "'and state = '" + "배송 중" + "' and product.pcode=buy.pcode and bday between '" + between_A + "' and '"
					+ between_B + "';";
		else if (between_A == null && between_B == null)
			sql = "select bcode, product.name, bnum, (bnum*price), bday, state from buy, product " + "where id = '" + id
					+ "' and state = '" + "배송 중" + "'and product.pcode=buy.pcode;";

		return selectQuery(sql);
	}

	// 관리자 회원가입
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

	// 관리자 아이디 찾기
	public static String findManagerId(String name, String phoneNum) {

		String sql = "select id from manager where name='" + name + "' and phone ='" + phoneNum + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false값, resultset 객체를 저장하고 있음.
			rs = stmt.getResultSet(); // resultset 객체를 받아서 ResultSet의 참조변수 rs에 넣어줌

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

	// 관리자 비번 찾기
	public static String findManagerPwd(String id, String name) {

		String sql = "select pw from manager where id='" + id + "' and name ='" + name + "';";
		try {
			stmt = con.createStatement();
			stmt.executeQuery(sql); // true, false값, resultset 객체를 저장하고 있음.
			rs = stmt.getResultSet(); // resultset 객체를 받아서 ResultSet의 참조변수 rs에 넣어줌

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

	// 관리자 정보수정?
	public static int M_InfoChgConfirm(String id, String passwd, String phone) {

		String encrypted = null;

		try {
			encrypted = AES256.encryptAES256(passwd, key);
		} catch (InvalidKeyException | NoSuchAlgorithmException | InvalidKeySpecException | NoSuchPaddingException
				| InvalidParameterSpecException | UnsupportedEncodingException | BadPaddingException
				| IllegalBlockSizeException e) {
			System.out.println("정보수정 오류: " + e.getMessage());
			e.printStackTrace();
		}

		String sql = "update manager set pw='" + encrypted + "', phone='" + phone + "' where id = '" + id + "';";

		return updateQuery(sql);
	}

	public static ResultSet selectDeliveryStatus(String state, String date1, String date2) {
		String sql = null;

		if (state.equals("전체") && date1 == null && date2 == null)
			sql = "select bday, id, name, state from buy, product where buy.pcode=product.pcode;";
		else if (state.equals("전체") && date1 != null && date2 != null)
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

	// 관리자 메뉴 - 상품 추가: product테이블에 값을 넣어줌
	public static int insertProduct(String pcode, String name, int price, int stock, int minst) {
		String sql = null;

		sql = "insert into product values('" + pcode + "', '" + name + "', " + price + ", " + stock + ", " + minst
				+ ");";

		return insertQuery(sql);
	}

	// 관리자 메뉴 - 상품 추가 내역 테이블(addp)에 값을 넣어줌
	public static int insertAddP(String id, String pcode) {
		String sql = null;
		Date date = new Date();
		SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd");

		sql = "insert into addp values('" + id + "', '" + time.format(date) + "', '" + pcode + "');";

		return insertQuery(sql);
	}

	// 관리자 메뉴 - 상품 추가시 코드 체크(예외 처리)
	public static boolean checkPcode(String pcode) {
		String sql = null;

		sql = "select pcode from product where pcode='" + pcode + "';";

		return checkQuery(sql);
	}

	// 관리자 메뉴 - 상품 추가시 상품명 체크(예외 처리)
	public static boolean checkPname(String pname) {
		String sql = null;

		sql = "select name from product where name='" + pname + "';";

		return checkQuery(sql);
	}

	// 상품 코드 추출
	public static String getPcode(String pname) {
		String pcode = null;

		try {
			String sql = "select pcode from product where name='" + pname + "';";

			rs = selectQuery(sql);

			if (rs.next())
				pcode = rs.getString("pcode");

		} catch (SQLException e) {
			System.err.println("getPcode 오류:" + e.getMessage());
			e.printStackTrace();
		}

		return pcode;
	}

	// product테이블의 pcode로 pname을 구하여 반환
	public static String getPname(String pcode) {
		String pname = null;
		try {
			String sql = "select name from product where pcode='" + pcode + "';";

			rs = selectQuery(sql);

			if (rs.next())
				pname = rs.getString("name");

		} catch (SQLException e) {
			System.err.println("getPname 오류:" + e.getMessage());
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
				+ time.format(date) + "', '" + bnum + "', '배송 전');";

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
				+ time.format(date) + "', '" + bnum + "', " + buyPrice + ", '배송 전');";

		return updateQuery(sql);
	}

	public static int sending(String id) {
		int send_count = 0;

		try {
			String sql = "select count(state) from buy where id='" + id + "' and state='배송 중';";
			
			rs = selectQuery(sql);

			if (rs.next())
				send_count = rs.getInt("count(state)");

		} catch (SQLException e) {
			System.err.println("sending() 오류:" + e.getMessage());
			e.printStackTrace();
		}

		return send_count;
	}

	public static int complete(String id) {
		int com_count = 0;

		try {
			String sql = "select count(state) from buy where id='" + id + "' and state='배송 완료';";
			
			rs = selectQuery(sql);

			if (rs.next())
				com_count = rs.getInt("count(state)");

		} catch (SQLException e) {
			System.err.println("sending() 오류:" + e.getMessage());
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
			System.err.println("sending() 오류:" + e.getMessage());
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
			System.err.println("sending() 오류:" + e.getMessage());
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
			System.err.println("sending() 오류:" + e.getMessage());
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
			System.err.println("sending() 오류:" + e.getMessage());
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
					+ pname + "'," + Math.floor(buyPrice * 0.03) + ",'적립');";
		else if (point != 0)
			sql = "insert into point (pdate,id,name,point,state) values('" + time.format(date) + "','" + id + "'" + ",'"
					+ pname + "'," + point + ",'사용');";

		return updateQuery(sql);
	}

	// 가상화폐 업데이트
	public static int updateAccount(int add_account, String id) {
		String sql = "update consumer set account = account + " + add_account + " where id='" + id + "';";

		return updateQuery(sql);
	}

	// 가상화폐 불러오기
	public static int getAccount(String id) {
		int account = 0;

		try {
			String sql = "select account from consumer where id='" + id + "';";

			rs = selectQuery(sql);

			if (rs.next())

				account = rs.getInt("account");

		} catch (SQLException e) {
			System.err.println("account 오류:" + e.getMessage());
			e.printStackTrace();
		}

		return account;
	}

	public static ResultSet selectPointStatus(String id, String state, String date1, String date2) {
		String sql = null;

		if (date1 != null && date2 != null) {
			if (state.equals("전체"))
				sql = "select pdate, sum(point), state from point where id='" + id + "' and pdate between '" + date1
						+ "' and '" + date2 + "' group by pdate, state order by pdate, state;";
			else
				sql = "select pdate, sum(point), state from point where id='" + id + "' and state='" + state
						+ "' and pdate between '" + date1 + "' and '" + date2
						+ "' group by pdate, state order by pdate, state;";
		} else if (date1 == null && date2 == null) {
			if (state.equals("전체"))
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
			System.err.println("sending() 오류:" + e.getMessage());
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
			System.err.println("sending() 오류:" + e.getMessage());
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
			// 연결을 닫는다.
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
