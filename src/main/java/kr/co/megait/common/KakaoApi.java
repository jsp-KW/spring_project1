package kr.co.megait.common;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

import javax.net.ssl.HttpsURLConnection;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class KakaoApi {
   
   private static final String REST_API = "7cbd06ccb036861ca087b9b1e28ee8b5";
   private static final String JAVASCRIPT_API = "71a383ea400e6eab6628c65e3e238e5f";
   private static final String ADMIN_API = "f170eb666c3030bac5b9f52e85872893";
         
   /**
    * GPS 좌표 - > 주소 변환
    * @param x
    * @param y
    * @return
    */
    public static String coordToAddr(double x, double y){
        String url = "https://dapi.kakao.com/v2/local/geo/coord2address.json?x="+x+"&y="+y+"&input_coord=WGS84";
        String addr = "";
        try{
            addr = getRegionAddress(getJSONData(url));
//            logger.info(addr);
            System.out.println(addr);
        }catch(Exception e){
//            logger.error("주소 api 요청 에러", e);
           System.out.println("주소 api 요청 에러 : "+e);
            e.printStackTrace();
        }
        return addr;
    }
    
    
    /**
     * 주소 -> GPS 좌표 변환
     * @param location
     * @return
     * @throws Exception 
     */
    public static double[] AddrTocoord(String location) throws Exception {
       
        String url = "https://dapi.kakao.com/v2/local/search/address.json?query="+URLEncoder.encode(location, "UTF-8")+"";
        double[] coords = null;
        
        try {
           
           coords = getCoords(getJSONData(url));
           
        }catch(Exception e){
           System.out.println("GPS api 요청 에러 : "+e);
           e.printStackTrace();
        }
       
       return coords;
    }
   
   
    /**
     * Response Data 받기
     * @param apiUrl
     * @return
     * @throws Exception
     */
    private static String getJSONData(String apiUrl) throws Exception {
        String jsonString = new String();
        String buf;
        URL url = new URL(apiUrl);
        HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();
        String auth = "KakaoAK "+REST_API;
        conn.setRequestMethod("GET");
        conn.setRequestProperty("X-Requested-With", "curl");
        conn.setRequestProperty("Authorization", auth);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(
                conn.getInputStream(), "UTF-8"));
        while ((buf = br.readLine()) != null) {
            jsonString += buf;
        }
        System.out.println(jsonString);
        return jsonString;
    }
    
    
    /**
     * JSON 데이터 파싱
     * @param jsonString
     * @return
     */
    private static String getRegionAddress(String jsonString) {
        String value = "";
        JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
        JSONObject meta = (JSONObject) jObj.get("meta");
        long size = (long) meta.get("total_count");
        if(size>0){
            JSONArray jArray = (JSONArray) jObj.get("documents");
            JSONObject subJobj = (JSONObject) jArray.get(0);
            JSONObject roadAddress =  (JSONObject) subJobj.get("road_address");
            if(roadAddress == null){
                JSONObject subsubJobj = (JSONObject) subJobj.get("address");
                value = (String) subsubJobj.get("address_name");
            }else{
                value = (String) roadAddress.get("address_name");
            }
            if(value.equals("") || value==null){
                subJobj = (JSONObject) jArray.get(1);
                subJobj = (JSONObject) subJobj.get("address");
                value =(String) subJobj.get("address_name");    
            }
        }
        return value;
    }

    
    /**
     * JSON 데이터 파싱
     * @param jsonString
     * @return
     */
    private static double[] getCoords(String jsonString) {
       
       double[] coords = {(double)0, (double)0};
       String Lat = "";
       String Long = "";
       
        JSONObject jObj = (JSONObject) JSONValue.parse(jsonString);
        JSONObject meta = (JSONObject) jObj.get("meta");
        long size = (long) meta.get("total_count");
        if(size>0){
            JSONArray jArray = (JSONArray) jObj.get("documents");
            JSONObject subJobj = (JSONObject) jArray.get(0);
            JSONObject roadAddress =  (JSONObject) subJobj.get("road_address");
            if(roadAddress == null){
                JSONObject subsubJobj = (JSONObject) subJobj.get("address");
                Lat = (String)subsubJobj.get("y");
                Long = (String)subsubJobj.get("x");
            }else{
                Lat = (String)roadAddress.get("y");
                Long = (String)roadAddress.get("x");
            }
            
            coords[0] = Double.parseDouble(Lat);
            coords[1] = Double.parseDouble(Long);
            
//            if(value.equals("") || value==null){
//                subJobj = (JSONObject) jArray.get(1);
//                subJobj = (JSONObject) subJobj.get("address");
//                value =(String) subJobj.get("address_name");    
//            }

        }
       
       return coords;
       
    }
   
   
   
}