package nine.kkh.human.model.service;

import java.util.List;

import org.springframework.http.ResponseEntity;

import nine.kkh.human.model.HumanDto;

public interface HumanService {

	List<HumanDto> listHuman() throws Exception;
	void updateHuman(HumanDto humanDto) throws Exception;
	void deleteHuman(String name) throws Exception;
	List<HumanDto> searchListHuman(String keyName) throws Exception;
	int getHumanCnt(String checkName) throws Exception;
	void insertHuman(HumanDto humanDto) throws Exception;

}
