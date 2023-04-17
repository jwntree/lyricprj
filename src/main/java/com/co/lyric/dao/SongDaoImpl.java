package com.co.lyric.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.SongVO;

@Repository
public class SongDaoImpl implements SongDao {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public int create(SongVO vo) throws Exception {
        sqlSession.insert("songMapper.insertSong",vo);
        return vo.getLyricId();
	}

	@Override
	public SongVO read(int songId) throws Exception {
        return sqlSession.selectOne("songMapper.songView",songId);
	}

	@Override
	public int update(SongVO vo) throws Exception {
		return sqlSession.update("songMapper.updateSong",vo);
		
	}

	@Override
	public int delete(SongVO vo) throws Exception {
		return sqlSession.delete("songMapper.deleteSong",vo);
	}

	@Override
	public List<SongVO> list(String searchOption, String keyword, Criteria cri) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("searchOption", searchOption);
	    map.put("keyword", keyword);
	    map.put("start", cri.getRowStart());
	    map.put("end", cri.getRowEnd());
        return sqlSession.selectList("songMapper.songList",map);

	}


	@Override
	public int countArticle(String searchOption, String keyword) {
	    // 검색옵션, 키워드 맵에 저장
	    Map<String, String> map = new HashMap<String, String>();
	    map.put("searchOption", searchOption);
	    map.put("keyword", keyword);
	    return sqlSession.selectOne("songMapper.countArticle", map);
	}

	@Override
	public int updateSongLyric(SongVO vo) throws Exception {
		return sqlSession.update("songMapper.updateSongLyric",vo);
	}
	
	public int getSongIdByLyricId(int LyricId) throws Exception{
	    return sqlSession.selectOne("songMapper.getSongIdByLyricId", LyricId);

	}


}
