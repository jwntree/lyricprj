package com.co.lyric.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.co.lyric.dao.SongDao;
import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.SongVO;

@Service
public class SongServiceImpl implements  SongService{

	@Inject 
	SongDao songDao;

	@Override
	public int create(SongVO vo) throws Exception {
		return songDao.create(vo);
	}

	@Override
	public SongVO read(int songId) throws Exception {
		SongVO vo = songDao.read(songId);
		return vo;
	}

	@Override
	public int update(SongVO vo) throws Exception {
		return songDao.update(vo);
	}

	@Override
	public int delete(SongVO vo) throws Exception {
		return songDao.delete(vo);
	}

	@Override
	public List<SongVO> list(String searchOption, String keyword, Criteria cri) {
		return songDao.list(searchOption,keyword,cri);
	}

	@Override
	public int countArticle(String searchOption, String keyword) {
		return songDao.countArticle(searchOption,keyword); 
	}

	@Override
	public int updateSongLyric(SongVO vo) throws Exception {
		return songDao.updateSongLyric(vo);
	}

	@Override
	public int getSongIdByLyricId(int LyricId) throws Exception {
		return songDao.getSongIdByLyricId(LyricId);

	}

	
	

}
