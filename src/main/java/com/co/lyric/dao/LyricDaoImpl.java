package com.co.lyric.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.co.lyric.vo.Criteria;
import com.co.lyric.vo.LyricHistroyVO;
import com.co.lyric.vo.LyricVO;

@Repository
public class LyricDaoImpl implements LyricDao{

	@Inject
	SqlSession sqlSession;
	
	@Override
	public int create(LyricVO vo) throws Exception {
        sqlSession.insert("lyricMapper.insertLyric",vo);
        return vo.getLyricId();
	}

	@Override
	public LyricVO read(int lyricId) throws Exception {
        return sqlSession.selectOne("lyricMapper.LyricView",lyricId);
	}

	@Override
	public int update(LyricVO vo) throws Exception {
		return sqlSession.update("lyricMapper.updateLyric",vo);
		
	}

	@Override
	public int delete(LyricVO vo) throws Exception {
		return sqlSession.delete("lyricMapper.deleteLyric",vo);
	}

	@Override
	public List<LyricVO> list() {
        return sqlSession.selectList("lyricMapper.view");

	}

	@Override
	public List<LyricHistroyVO> HistoryList(int lyricId, Criteria cri) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("lyricId", lyricId);
	    map.put("start", cri.getRowStart());
	    map.put("end", cri.getRowEnd());
        return sqlSession.selectList("lyricMapper.LyricHistory",map);
	}

	@Override
	public LyricHistroyVO HistoryView(int revId) {
        return sqlSession.selectOne("lyricMapper.LyricHistoryView",revId);
	}

	@Override
	public int CountHistoryArticle(int lyricId) {
        return sqlSession.selectOne("lyricMapper.CountHistoryArticle",lyricId);
	}
	
	@Override
	public int restoreLyric(int lyricId, int revId) {
	    Map<String, Object> map = new HashMap<String, Object>();
	    map.put("lyricId", lyricId);
	    map.put("revId", revId);
		return sqlSession.update("lyricMapper.restoreLyric",map);
	}


}
