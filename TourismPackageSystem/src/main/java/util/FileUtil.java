package util;
import java.io.File;
public class FileUtil{
 private static final String BASE=System.getProperty("user.home")+File.separator+"TourismPackageData"+File.separator;
 public static String path(String name){File dir=new File(BASE); if(!dir.exists()) dir.mkdirs(); return BASE+name;}
 public static String folder(){File dir=new File(BASE); if(!dir.exists()) dir.mkdirs(); return BASE;}
}
