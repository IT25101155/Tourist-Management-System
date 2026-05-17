package service;
import model.Notification; import util.FileUtil; import java.io.*; import java.util.*;
public class NotificationService{private static final String FILE=FileUtil.path("notifications.txt");
 public boolean add(Notification n){try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE,true))){bw.write(n.toFileString());bw.newLine();return true;}catch(Exception e){e.printStackTrace();return false;}}
 public List<Notification> all(){List<Notification> l=new ArrayList<>(); File f=new File(FILE); if(!f.exists())return l; try(BufferedReader br=new BufferedReader(new FileReader(FILE))){String line; while((line=br.readLine())!=null){String[] d=line.split(",",-1); if(d.length==5)l.add(new Notification(d[0],d[1],d[2],d[3],d[4]));}}catch(Exception e){e.printStackTrace();} return l;}
 public List<Notification> byUser(String username){List<Notification> out=new ArrayList<>(); for(Notification n:all()) if(n.getUsername().equals(username)||n.getUsername().equalsIgnoreCase("ALL")) out.add(n); return out;}
 public boolean update(Notification updated){List<Notification> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(Notification n:list){bw.write(n.getId().equals(updated.getId())?updated.toFileString():n.toFileString());bw.newLine();}return true;}catch(Exception e){e.printStackTrace();return false;}}
 public boolean delete(String id){List<Notification> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(Notification n:list) if(!n.getId().equals(id)){bw.write(n.toFileString());bw.newLine();}return true;}catch(Exception e){e.printStackTrace();return false;}}
}
