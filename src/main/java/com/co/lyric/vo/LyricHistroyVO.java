package com.co.lyric.vo;

import java.util.Date;

public class LyricHistroyVO extends LyricVO {
	private int revId;

	public int getRevId() {
		return revId;
	}

	public void setRevId(int revId) {
		this.revId = revId;
	}

	@Override
	public String toString() {
		return "LyricHistroyVO [revId=" + revId + ", lyricId=" + lyricId + ", submitterName=" + submitterName
				+ ", submitterEmail=" + submitterEmail + ", regDate=" + regDate + ", texts=" + texts + "]";
	}
	
}
