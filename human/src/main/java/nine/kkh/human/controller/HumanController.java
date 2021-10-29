package nine.kkh.human.controller;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import nine.kkh.human.model.HumanDto;
import nine.kkh.human.model.service.HumanService;

@Controller
public class HumanController {
	@Autowired
	HumanService humanService;
	
	@RequestMapping("/")
	public String index() {
		return "index";
	}
	
	@GetMapping("/list")
	@ResponseBody
	public ResponseEntity<List<HumanDto>> listHuman() throws Exception {
		List<HumanDto> list = humanService.listHuman();
		if (list != null && !list.isEmpty()) { // 정상
			return new ResponseEntity<List<HumanDto>>(list, HttpStatus.OK);
		} else { // 데이터 없음
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
	}
	
	@PutMapping("/human")
	@ResponseBody
	public ResponseEntity<List<HumanDto>> updateHuman(@RequestBody HumanDto humanDto) throws Exception {
		humanService.updateHuman(humanDto);
		return listHuman();
	}
	
	@DeleteMapping("/human/{name}")
	@ResponseBody
	public ResponseEntity<List<HumanDto>> deleteHuman(@PathVariable("name") String name) throws Exception {
		humanService.deleteHuman(name);
		return listHuman();
	}
	
	@GetMapping("/list/{keyName}")
	@ResponseBody
	public ResponseEntity<List<HumanDto>> searchListHuman(@PathVariable("keyName") String keyName) throws Exception {
		List<HumanDto> list = humanService.searchListHuman(keyName);
		if (list != null && !list.isEmpty()) { // 정상
			return new ResponseEntity<List<HumanDto>>(list, HttpStatus.OK);
		} else { // 데이터 없음
			return new ResponseEntity(HttpStatus.NO_CONTENT);
		}
	}
	
	@GetMapping("/humanCount/{checkName}")
	@ResponseBody
	public ResponseEntity<String> getHumanCount(@PathVariable("checkName") String checkName) throws Exception {
		int cnt = humanService.getHumanCnt(checkName);
		JSONObject json = new JSONObject();
		json.put("cnt", cnt);
		return new ResponseEntity<String> (json.toString(), HttpStatus.OK);
	}
	@PostMapping("/human")
	@ResponseBody
	public ResponseEntity<List<HumanDto>> insertHuman(@RequestBody HumanDto humanDto) throws Exception {
		humanService.insertHuman(humanDto);
		return listHuman();
	}
} // end of class
