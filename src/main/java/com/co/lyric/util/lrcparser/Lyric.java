package com.co.lyric.util.lrcparser;
public class Lyric {
	int time;
	String text;
	LineType type;
	Lyric(Lyric lc) {
		time = lc.time;
		type = lc.type;
		text = lc.text;
	}

	public Lyric() {
	}
}
