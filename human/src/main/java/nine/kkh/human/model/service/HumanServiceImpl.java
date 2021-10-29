package nine.kkh.human.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import nine.kkh.human.model.HumanDto;
import nine.kkh.human.model.mapper.HumanMapper;

@Service
public class HumanServiceImpl implements HumanService{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<HumanDto> listHuman() throws Exception {
		return sqlSession.getMapper(HumanMapper.class).listHuman();
	}
	@Override
	public void updateHuman(HumanDto humanDto) throws Exception {
		sqlSession.getMapper(HumanMapper.class).updateHuman(humanDto);
	}
	@Override
	public void deleteHuman(String name) throws Exception {
		sqlSession.getMapper(HumanMapper.class).deleteHuman(name);
	}
	@Override
	public List<HumanDto> searchListHuman(String keyName) throws Exception {
		return sqlSession.getMapper(HumanMapper.class).searchListHuman(keyName);
	}
	@Override
	public int getHumanCnt(String checkName) throws Exception {
		return sqlSession.getMapper(HumanMapper.class).getHumanCnt(checkName);
	}
	@Override
	public void insertHuman(HumanDto humanDto) throws Exception {
		sqlSession.getMapper(HumanMapper.class).insertHuman(humanDto);
	}
}
