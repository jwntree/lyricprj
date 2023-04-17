package com.co.lyric.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.co.lyric.service.LyricService;
import com.co.lyric.service.SongService;
import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.LyricHistroyVO;
import com.co.lyric.vo.LyricVO;
import com.co.lyric.vo.PageMaker;
import com.co.lyric.vo.SongVO;

@Controller
@RequestMapping("/song/*")
public class SongController {

	@Inject 
	SongService songservice;
	@Inject
	LyricService lyricservice;
	
	//게시글 리스트
	@RequestMapping(value="list")
	public String list(@RequestParam(defaultValue="") String searchOption,
            @RequestParam(defaultValue="") String keyword,
            @RequestParam(defaultValue="1") int curPage,
            @RequestParam(defaultValue="5") int perPage,
            Model model) throws Exception{
		Criteria cri = new Criteria();
		cri.setPage(curPage);
		cri.setPerPageNum(perPage);
		List<SongVO> list = songservice.list(searchOption, keyword,cri);
	    int count = songservice.countArticle(searchOption, keyword);
		
	    PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(count);
		
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("keyword", keyword);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("curPage", curPage);
		model.addAttribute("perPage", perPage);

		return "song/list";
	}
	
	//게시글 작성화면
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String write() throws Exception{
        return "song/write";
	}
	
	//게시글 작성처리
    @RequestMapping(value="writeForm", method=RequestMethod.POST)
    public String writeForm(@ModelAttribute SongVO vo, HttpSession session) throws Exception{
        
    	songservice.create(vo);
        int songId = vo.getSongId(); //insert후 select Key에 의해 SongId값 세팅됨}
        return "redirect:/song/list";
    }
	
    //게시글 조회
    
	@RequestMapping(value="view", method=RequestMethod.GET)
	public String view(@RequestParam(defaultValue = "-1") int songId, Model model) throws Exception{
		//TODO: Redirection to Error Page
		if(songId < 1) {
	        return "redirect:/song/list";
		}
		SongVO vo =  songservice.read(songId);
		if(vo == null) {
			//logger.debug("게시글이 없습니다.");
	        return "redirect:/song/list";
		}else {
			//logger.debug("게시글이 존재합니다.");

			model.addAttribute("song", vo);
			if(vo.getLyricId() > 0) {
				LyricVO lycVo =  lyricservice.read(vo.getLyricId());
				if(lycVo != null && lycVo.getTexts() != null) {
					//String newTexts = lycVo.getTexts().replaceAll("\n", "<br>"); //TODO: Raw Text를 받아 개행문자를 치환하여 표시하는대신 에디터로 html을 받아 db에 저장
					//lycVo.setTexts(newTexts);
					model.addAttribute("lyric", lycVo);
				}
			}
	        return "song/view";
		}
	}
	
	//게시글 업데이트 View
    @RequestMapping(value="update")
    public String update(@RequestParam(defaultValue = "-1") int songId, Model model) throws Exception{
		if(songId < 1) {
	        return "redirect:/song/list";
		}
		SongVO vo =  songservice.read(songId);
		model.addAttribute("song", vo);
        return "song/update";
    }
    
    //게시글 업데이트 POST
	@ResponseBody
	@RequestMapping(value="updateForm", method=RequestMethod.POST)
    public boolean updateForm(@ModelAttribute SongVO vo, HttpSession session) throws Exception{
  	
    	return songservice.update(vo) != 0;
    	
    }
	
	//이미지 업로드 창
	@RequestMapping(value="ImageUpload")
    public String ImageUplad(@ModelAttribute SongVO vo, HttpSession session) throws Exception{
  	
    	return "song/imageUpload";
    	
    }
	
	//가사 update View
	@RequestMapping(value="lyricUpdate", method=RequestMethod.GET)
	public String lyricUpdate(@RequestParam(defaultValue = "-1") int songId, Model model) throws Exception{
		//TODO: Redirection to Error Page
		if(songId < 1) {
	        return "redirect:/song/list";
		}
		SongVO vo =  songservice.read(songId);
		if(vo == null) {
	        return "redirect:/song/list";
		}else {
			model.addAttribute("song", vo);
			if(vo.getLyricId() > 0) {
				LyricVO lycVo =  lyricservice.read(vo.getLyricId());
				if(lycVo != null && lycVo.getTexts() != null) {
					model.addAttribute("lyric", lycVo);
				}
			}
	        return "song/lyricwrite";
		}
	}
	
	//가사 update Post
	//Respond Body로 변경 필요
	@RequestMapping(value="writeLyricForm", method=RequestMethod.POST)
    public String lyricupdateForm(@RequestParam(defaultValue = "-1") int songId, @ModelAttribute LyricVO lyricvo, HttpSession session) throws Exception{
		//TODO: Redirection to Error Page
		//Consider to use Respond Body
		if(songId < 1) {
	        return "redirect:list.do";
		}
		SongVO songVo =  songservice.read(songId);
		if(songVo == null) {
	        return "redirect:/song/list";
		}else {
			int lyricId =  songVo.getLyricId();
			if(lyricId < 1) {
				//lyricId = 0 : no Lyric. make New Lyric.
				int id = lyricservice.create(lyricvo);
				songVo.setLyricId(id);
				songservice.updateSongLyric(songVo);
		        return "redirect:/song/list";
			}else {
				//lyricId > 0 : updateLyric.
				lyricvo.setLyricId(lyricId);
				lyricservice.update(lyricvo);
		        return "redirect:/song/list";
			}
		}
    }
	
	
	//게시글 리스트
	@RequestMapping(value="lyricHistory")
	public String LyricHistory(
			@RequestParam(defaultValue = "-1") int songId,
            @RequestParam(defaultValue="1") int curPage,
            @RequestParam(defaultValue="5") int perPage,
            Model model) throws Exception{
		
		Criteria cri = new Criteria();
		cri.setPage(curPage);
		cri.setPerPageNum(perPage);
		
		int count = 0;
		List<LyricHistroyVO> list = new ArrayList<LyricHistroyVO>();
		
		//TODO: Redirection to Error Page
		if(songId < 1) {
	        return "redirect:/song/list";
		}
		SongVO songVo =  songservice.read(songId);
		if(songVo == null) {
	        return "redirect:/song/list";
		}else {
			int lyricId =  songVo.getLyricId();
			if(lyricId > 0) {
			    count = lyricservice.CountHistoryArticle(lyricId);
				list = lyricservice.HistoryList(lyricId, cri);
			}
		}

		
	    PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(count);
		
		model.addAttribute("songId", songId);
		model.addAttribute("list", list);
		model.addAttribute("count", count);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("curPage", curPage);
		model.addAttribute("perPage", perPage);

		return "song/lyricHistory";
	}
	
	//게시글 리스트
	@RequestMapping(value="lyricHistoryView")
	public String lyricHistoryView(
			@RequestParam(defaultValue = "-1") int revId,
            Model model) throws Exception{
		if(revId < 1) {
	        return "redirect:/song/list";
		}
		LyricHistroyVO vo =  lyricservice.HistoryView(revId);
		if(vo == null) {
			//logger.debug("게시글이 없습니다.");
	        return "redirect:/song/list";
		}else {
			//logger.debug("게시글이 존재합니다.");

			model.addAttribute("lyric", vo);
		}
		return "song/lyricHistoryView";
	}
	
	//게시글 리스트
	@ResponseBody
	@RequestMapping(value="restoreLyric")
	public Map<String, Object> restoreLyric(
			@RequestParam(defaultValue = "-1") int revId,
			@RequestParam(defaultValue = "-1") int lyricId
            ) throws Exception{
	
		Map<String, Object> map = new TreeMap<String, Object>();
		
		if(revId < 1 || lyricId < 1) {
			map.put("responseCode", "error");
	        return map;
		}
		LyricHistroyVO vo =  lyricservice.HistoryView(revId);
		int result = lyricservice.restoreLyric(lyricId, revId);
		if(vo == null) {
			//logger.debug("게시글이 없습니다.");
			map.put("responseCode", "error");
	        return map;
		}else {
			//logger.debug("게시글이 존재합니다.");
			map.put("responseCode", "success");
		}
		return map;
	}
}
