package com.co.lyric.dao;

import java.util.List;

import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.LyricHistroyVO;
import com.co.lyric.vo.LyricVO;

public interface LyricDao {
	public int create(LyricVO vo) throws Exception;
	public LyricVO read(int lyricId) throws Exception;
	public int update(LyricVO vo) throws Exception;
	public int delete(LyricVO vo) throws Exception;
	public List<LyricVO> list();
	
	//가사 히스토리
	public List<LyricHistroyVO> HistoryList(int lyric_id, Criteria cri);
	public LyricHistroyVO HistoryView(int revId);
	public int CountHistoryArticle(int lyricId);
	public int restoreLyric(int lyricId, int revId);
}
