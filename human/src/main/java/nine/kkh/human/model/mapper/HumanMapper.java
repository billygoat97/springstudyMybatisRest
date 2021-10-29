package nine.kkh.human.model.mapper;

import java.util.List;

import org.springframework.http.ResponseEntity;

import nine.kkh.human.model.HumanDto;

public interface HumanMapper {

	List<HumanDto> listHuman() throws Exception;

	void updateHuman(HumanDto humanDto) throws Exception;

	void deleteHuman(String name) throws Exception;

	List<HumanDto> searchListHuman(String keyname) throws Exception;

	int getHumanCnt(String checkName) throws Exception;

	void insertHuman(HumanDto humanDto) throws Exception;


}
