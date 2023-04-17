package com.co.lyric.service;

import java.util.List;

import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.SongVO;

public interface SongService {
	public int create(SongVO vo) throws Exception;
	public SongVO read(int songId) throws Exception;
	public int update(SongVO vo) throws Exception;
	public int delete(SongVO vo) throws Exception;
	public List<SongVO> list(String searchOption, String keyword,Criteria cri);
	public int countArticle(String searchOption, String keyword);
	public int updateSongLyric(SongVO vo) throws Exception;
	public int getSongIdByLyricId(int LyricId) throws Exception;


}
