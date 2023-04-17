package com.co.lyric.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class UploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(UploadController.class);

	
	@RequestMapping("/uploadImage")
	@ResponseBody
	public Map<String, Object> uploadImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request ) throws Exception {
		Map<String, Object> map  = new LinkedHashMap<String, Object>();
		
		/*
		 * server.xml에 이 내용 꼭 추가
		 *       <Context path="/files" reloadable="true" docBase="C:\resource\files"/>
		 */
		 String fileRoot = "C:\\resource\\files\\"; // 외부경로로 저장
		
		// 내부경로로 저장
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		String savedFileName = UUID.randomUUID().toString().replaceAll("-","") + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			
			//썸네일
			//InputStream in = new FileInputStream(targetFile);
			//FileOutputStream thumbnail = new FileOutputStream(new File(fileRoot, "s_" + savedFileName));
			//Thumbnailator.createThumbnail(in, thumbnail, 200, 200);
			//thumbnail.close();
			
			Map<String, Object> listMap = null;
					
			map.put("url", "/files/"+savedFileName);
			map.put("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//오류시 저장된 파일 삭제
			map.put("responseCode", "error");
			e.printStackTrace();
		}
		
		return map;
	}
	

}
