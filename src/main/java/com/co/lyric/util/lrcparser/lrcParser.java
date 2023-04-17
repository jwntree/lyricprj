package com.co.lyric.util.lrcparser;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.*;

public class lrcParser {
	static public List <Lyric> read(String lyc){
		List <Lyric> lyrics = new ArrayList<Lyric>();
		String[] strs = lyc.split("\r\n");
		
		//String regex = "^\\[\\d\\d:\\d\\d.\\d\\d\\]";
		String regex = "^\\[(\\d\\d):(\\d\\d).(\\d\\d)\\]";
		Pattern pattern = Pattern.compile(regex);

		for(String str : strs) {
			Matcher matcher = pattern.matcher(str);
			if(!matcher.find()) {
				///*
				Lyric lc = new Lyric();
				lc.text = str;
				lc.time = 0;
				lc.type = LineType.Comment;
				lyrics.add(lc);
				//*/
				continue;
			}
			int minutes = Integer.parseInt(matcher.group(1));
			int sec  = Integer.parseInt(matcher.group(2));
			int cent = Integer.parseInt(matcher.group(3));
			int time = ((minutes * 60)+sec) *1000  + cent * 10;
			
			String text = str.substring(matcher.end(),str.length());
			Lyric lc = new Lyric();
			lc.text = text;
			lc.time = time;
			lc.type = LineType.Lyric;
			lyrics.add(lc);
		}
		return lyrics;
	}
	public static String write(List <Lyric> lc) throws Exception {
	
		String lyc = "";
		for(Lyric lycs : lc) {
			int millis  = lycs.time;
			int minutes = millis / 60000;
			millis -= minutes * 60000;
			int secs = millis / 1000;
			millis -= secs * 1000;
			String timeStr = String.format("%02d:%02d.%02d", minutes,secs,millis / 10);	
			lyc += '[' + timeStr + ']';
			lyc += lycs.text;
			lyc += "\n";
		}
		return lyc;
	}
}
