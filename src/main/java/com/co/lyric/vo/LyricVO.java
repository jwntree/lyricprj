package com.co.lyric.vo;

import java.util.Date;

public class LyricVO {
   	int lyricId;
	String submitterName;
	String submitterEmail;
	Date regDate;
	String texts;
	public int getLyricId() {
		return lyricId;
	}
	public void setLyricId(int lyricId) {
		this.lyricId = lyricId;
	}
	public String getSubmitterName() {
		return submitterName;
	}
	public void setSubmitterName(String submitterName) {
		this.submitterName = submitterName;
	}
	public String getSubmitterEmail() {
		return submitterEmail;
	}
	public void setSubmitterEmail(String submitterEmail) {
		this.submitterEmail = submitterEmail;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getTexts() {
		return texts;
	}
	public void setTexts(String texts) {
		this.texts = texts;
	}
	@Override
	public String toString() {
		return "LyricVO [lyricId=" + lyricId + ", submitterName=" + submitterName + ", submitterEmail=" + submitterEmail
				+ ", regDate=" + regDate + ", texts=" + texts + "]";
	}
	
	
}
