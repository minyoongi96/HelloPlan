package kr.calender.dao;

import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.calender.entity.Place;
import kr.calender.entity.Plan;
import kr.calender.entity.User;

public class CalenderMyBatisDAO {
	private static SqlSessionFactory sqlSessionFactory;
	
	static {
		String resource = "kr/calender/dao/mybatis-config.xml";
		try {
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// user 로그인
	public User userLogin(User vo) {
		SqlSession session = sqlSessionFactory.openSession();
		User user = session.selectOne("userLogin", vo);
		session.close();
		
		return user;
	}
	
	// user 탈퇴
	public int userDelete(String user_id) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.delete("userDelete", user_id);
		session.commit();
		session.close();
		
		return cnt;
	}	
	
	public int userInsert(User vo) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.insert("userInsert", vo);
		session.commit();
		session.close();
		
		return cnt;
	}
	
	public int planInsert(Plan vo) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.insert("planInsert", vo);
		session.commit();
		session.close();
		
		return cnt;
	}
	
	public int planDelete(int plan_seq) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.delete("planDelete", plan_seq);
		session.commit();
		session.close();
		
		return cnt;
	}
	
	public int userIDCheck(String user_id) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt= session.selectOne("userIDCheck", user_id);
		session.close();
		
		return cnt;
	}
	
	public int planCount(String user_id) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt= session.selectOne("planCount", user_id);
		
		session.close();
		
		return cnt;
	}
	
	public List<Plan> planSelectAll(String user_id) {
		SqlSession session = sqlSessionFactory.openSession();
		List<Plan> result = session.selectList("planSelectAll", user_id);
		session.close();
		
		return result;
	}
	
	public Plan planSelect(int plan_seq) {
		SqlSession session = sqlSessionFactory.openSession();
		Plan result = session.selectOne("planSelect", plan_seq);
		session.close();
		
		return result;
	}
	
	public int planUpdate(Plan vo) {
		SqlSession session = sqlSessionFactory.openSession();
		int cnt = session.update("planUpdate", vo);
		session.commit();
		session.close();
		
		return cnt;
	}
}
