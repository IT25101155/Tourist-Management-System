package service;
import model.Review; import util.FileUtil; import java.io.*; import java.util.*;
public class ReviewService{private static final String FILE=FileUtil.path("reviews.txt");
 public boolean add(Review r){try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE,true))){bw.write(r.toFileString());bw.newLine();return true;}catch(Exception e){e.printStackTrace();return false;}}
 public List<Review> all(){List<Review> l=new ArrayList<>(); File f=new File(FILE); if(!f.exists())return l; try(BufferedReader br=new BufferedReader(new FileReader(FILE))){String line;while((line=br.readLine())!=null){String[] d=line.split(",",-1); if(d.length==5)l.add(new Review(d[0],d[1],d[2],Integer.parseInt(d[3]),d[4]));}}catch(Exception e){e.printStackTrace();}return l;}
 public Review getById(String id){for(Review r:all()) if(r.getId().equals(id))return r; return null;}
 public boolean update(Review updated,String username){List<Review> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(Review r:list){if(r.getId().equals(updated.getId())&&r.getUsername().equals(username))bw.write(updated.toFileString()); else bw.write(r.toFileString()); bw.newLine();}return true;}catch(Exception e){e.printStackTrace();return false;}}
 public boolean delete(String id,String username,boolean admin){List<Review> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(Review r:list){boolean can=admin||r.getUsername().equals(username); if(!(r.getId().equals(id)&&can)){bw.write(r.toFileString());bw.newLine();}}return true;}catch(Exception e){e.printStackTrace();return false;}}
}
