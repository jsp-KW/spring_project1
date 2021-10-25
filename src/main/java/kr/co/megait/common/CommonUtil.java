package kr.co.megait.common;

import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.util.Enumeration;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.binary.Base64;



public class CommonUtil {
/*
	/**
	 * AES 암호화 함수
	 * @param text
	 * @return
	 */
	public static String getEncrypt(String text) {
		
		String cryptoKey = "##megait1.test##";
		String encryptText = null;
		try {
			
			Key secureKey = new SecretKeySpec(cryptoKey.getBytes(), "AES");
			Cipher cipher = Cipher.getInstance("AES");
			// AES Cipher  객체 생성
			cipher.init(Cipher.ENCRYPT_MODE, secureKey);
			byte[] encrypteData = cipher.doFinal(text.getBytes());
			encryptText = byteArrayToHex(encrypteData);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return encryptText;
	}

	/**
	 * AES 스트링 복호화
	 * @param text
	 * @return
	 */
	public static String getDecrypt(String encryptText) {
		
		String CryptoKey = "##megait1.test##";
		
	    String decryptText = null;

	    try {
	    	
	        Key secureKey = new SecretKeySpec(CryptoKey.getBytes(), "AES");
	        Cipher cipher = Cipher.getInstance("AES");
	        cipher.init(Cipher.DECRYPT_MODE, secureKey);
	        byte[] decryptedData = cipher.doFinal( hexToByteArray(encryptText) );
	        decryptText = new String(decryptedData);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return decryptText;

	}

	
	
	/**
	 * byte[] to hex
	 * @param ba
	 * @return
	 */
	public static String byteArrayToHex(byte[] ba){
		if(ba==null || ba.length ==0){
			return null;
		}
		
		StringBuffer sb= new StringBuffer(ba.length*2);
		String hexNumber;
		for(int x=0;x<ba.length;x++){
			hexNumber = "0" + Integer.toHexString(0xff & ba[x]);
			sb.append(hexNumber.substring(hexNumber.length()-2));
		}
		
		return sb.toString();
	}
	
	
	/**
	 * hex to byte[]
	 * @param hex
	 * @return
	 */
	public static byte[] hexToByteArray(String hex){
		if(hex==null || hex.length()==0){
			return null;
		}
		
		byte[] ba= new byte[hex.length()/2];
		for(int i=0;i<ba.length;i++){
			ba[i]=(byte)Integer.parseInt(hex.substring(2*i,  2*i+2), 16);
		}
		
		return ba;
		
	}
	
	

	/**
	 * 문자를 Base64로 Encoding
	 * @param arg
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	
	public static String StringToBase64Encoding(String arg) throws UnsupportedEncodingException {
		
		String base64encoding = null;
		byte[] s_param = arg.getBytes("UTF-8");
		byte[] b_param= Base64.encodeBase64(s_param);
		base64encoding = new String(b_param);
		
		return base64encoding;
		
	}
	
	
	/**
	 * Base64에서 문자로 Decoding
	 * @param arg
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	
	public static String Base64ToStringDecoding(String arg) throws UnsupportedEncodingException {
		
		String base64decoding = null;
		byte[] s_param = arg.getBytes();
		byte[] b_param= Base64.decodeBase64(s_param);
		base64decoding = new String(b_param);
		
		return base64decoding;
		
	}
	
	
	   /**
	    * 현재 페이지 Url을 가져오는 메소드
	    * @param request
	    * @return
	    */
	   public static String getURL(HttpServletRequest request){
	      
	      Enumeration<?> param = request.getParameterNames();
	      
	      StringBuffer strParam = new StringBuffer();
	      StringBuffer strURL = new StringBuffer();

	      if(param.hasMoreElements()){
	         strParam.append("?");
	       }

	      while (param.hasMoreElements()){
	         String name = (String) param.nextElement();
	         String value = request.getParameter(name);
	         strParam.append(name+"="+value);
	         
	         if (param.hasMoreElements()) {
	            strParam.append("&");
	         }
	      }

	      strURL.append(request.getRequestURI());
	      strURL.append(strParam);

	      return strURL.toString();
	   }
	   

	   /**
	    * 방문자 IP 가져오기
	    * @param request
	    * @return
	    */
	   public String getIp(HttpServletRequest request) {

	      String ip = request.getHeader("X-Forwarded-For");

	      if (ip == null) {
	         ip = request.getHeader("Proxy-Client-IP");
	      }
	      if (ip == null) {
	         ip = request.getHeader("WL-Proxy-Client-IP"); // 웹로직
	      }
	      if (ip == null) {
	         ip = request.getHeader("HTTP_CLIENT_IP");
	      }
	      if (ip == null) {
	         ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	      }
	      if (ip == null) {
	         ip = request.getRemoteAddr();
	      }

	      return ip;

	   }
	
	
	
	
	
}


