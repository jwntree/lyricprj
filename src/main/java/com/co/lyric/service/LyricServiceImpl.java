package com.co.lyric.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.co.lyric.dao.LyricDao;
import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.LyricHistroyVO;
import com.co.lyric.vo.LyricVO;

@Service
public class LyricServiceImpl implements LyricService{

	@Inject 
	LyricDao lyricDao;

	@Override
	public int create(LyricVO vo) throws Exception {
		return lyricDao.create(vo);
	}

	@Override
	public LyricVO read(int lyricId) throws Exception {
		return lyricDao.read(lyricId);
	}

	@Override
	public int update(LyricVO vo) throws Exception {
		return lyricDao.update(vo);

	}

	@Override
	public int delete(LyricVO vo) throws Exception {
		return lyricDao.delete(vo);
	}

	@Override
	public List<LyricVO> list() {
		return lyricDao.list();
	}
	
	@Override
	public List<LyricHistroyVO> HistoryList(int lyricId, Criteria cri) {
		return lyricDao.HistoryList(lyricId, cri);
	}
	
	@Override
	public LyricHistroyVO HistoryView(int revId) {
		return lyricDao.HistoryView(revId);
	}
	
	@Override
	public int CountHistoryArticle(int lyricId) {
		return lyricDao.CountHistoryArticle(lyricId);
	}
	
	@Override
	public int restoreLyric(int lyricId, int revId) {
		return lyricDao.restoreLyric(lyricId,revId);

	}

	


}
