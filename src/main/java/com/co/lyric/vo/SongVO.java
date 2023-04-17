package com.co.lyric.vo;

public class SongVO {
	int songId;
	String title;
	String album;
	String artist;
	String year;
	String genre;
	String imageUrl;
	transient int lyricId;
	
	
	public int getSongId() {
		return songId;
	}
	public void setSongId(int songId) {
		this.songId = songId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAlbum() {
		return album;
	}
	public void setAlbum(String album) {
		this.album = album;
	}
	public String getArtist() {
		return artist;
	}
	public void setArtist(String artist) {
		this.artist = artist;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	
	public int getLyricId() {
		return lyricId;
	}
	public void setLyricId(int lyricId) {
		this.lyricId = lyricId;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	@Override
	public String toString() {
		return "SongVO [songId=" + songId + ", title=" + title + ", album=" + album + ", artist=" + artist + ", year="
				+ year + ", genre=" + genre + ", imageUrl=" + imageUrl + "]";
	}
	
	
}
