package com.co.lyric.dao;

import java.util.List;

import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.SongVO;

public interface SongDao {
	public int create(SongVO vo) throws Exception;
	public SongVO read(int lyricId) throws Exception;
	public int update(SongVO vo) throws Exception;
	public int delete(SongVO vo) throws Exception;
	public List<SongVO> list(String searchOption, String keyword, Criteria cri);
	public int countArticle(String searchOption, String keyword);
	public int updateSongLyric(SongVO vo) throws Exception;
	public int getSongIdByLyricId(int LyricId) throws Exception;

}
