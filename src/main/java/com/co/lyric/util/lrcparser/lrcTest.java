package com.co.lyric.util.lrcparser;
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.util.List;

import org.apache.commons.io.ByteOrderMark;
import org.apache.commons.io.input.BOMInputStream;

public class lrcTest {

	public static void main(String[] args) throws Exception {
		FileInputStream inputStream = new FileInputStream("We_.lrc");

	
		BOMInputStream bomInputStream = new BOMInputStream(inputStream,   ByteOrderMark.UTF_16LE, ByteOrderMark.UTF_16BE,
				   ByteOrderMark.UTF_32LE, ByteOrderMark.UTF_32BE);

		String lyc = "";
		ByteOrderMark bom = bomInputStream.getBOM();
		String defaultEncoding = "UTF-8";
		String charsetName = bom == null ? defaultEncoding : bom.getCharsetName();
        InputStreamReader reader = new InputStreamReader(new BufferedInputStream(bomInputStream), charsetName);

        
        BufferedReader in=new BufferedReader(reader);
        int ch;
		while((ch=in.read())!=-1){
        	lyc += (char)ch;
        }
		in.close();
		inputStream.close();

        List <Lyric> lyrics = lrcParser.read(lyc);
		String lyc2 = lrcParser.write(lyrics);
		int k = 0;

	}

}
