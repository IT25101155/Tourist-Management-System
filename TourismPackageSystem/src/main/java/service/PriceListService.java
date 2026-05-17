package service;
import util.FileUtil; import java.io.*; import java.util.*;
public class PriceListService{private static final String FILE=FileUtil.path("price_list.txt");
 public PriceListService(){ensureDefaults();}
 private void ensureDefaults(){File f=new File(FILE); if(f.exists())return; add("HOTEL","Budget Hotel",4500); add("HOTEL","Comfort Hotel",8500); add("HOTEL","Luxury Resort",18000); add("TRANSPORT","Shared Van",2500); add("TRANSPORT","Private Car",7000); add("TRANSPORT","Luxury Coach",12000); add("ACTIVITY","City Tour",3000); add("ACTIVITY","Safari",9500); add("ACTIVITY","Water Sports",8000);}
 public boolean add(String type,String name,double price){try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE,true))){bw.write(type+","+name.replace(","," ")+","+price);bw.newLine();return true;}catch(Exception e){e.printStackTrace();return false;}}
 public List<String[]> all(){ensureDefaults(); List<String[]> l=new ArrayList<>(); try(BufferedReader br=new BufferedReader(new FileReader(FILE))){String line;while((line=br.readLine())!=null){String[] d=line.split(",",-1); if(d.length==3)l.add(d);}}catch(Exception e){e.printStackTrace();} return l;}
 public List<String[]> byType(String type){List<String[]> out=new ArrayList<>(); for(String[] d:all()) if(d[0].equals(type))out.add(d); return out;}
 public boolean update(String type,String oldName,String name,double price){List<String[]> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(String[] d:list){if(d[0].equals(type)&&d[1].equals(oldName)) bw.write(type+","+name.replace(","," ")+","+price); else bw.write(String.join(",",d)); bw.newLine();}return true;}catch(Exception e){e.printStackTrace();return false;}}
 public boolean delete(String type,String name){List<String[]> list=all(); try(BufferedWriter bw=new BufferedWriter(new FileWriter(FILE))){for(String[] d:list) if(!(d[0].equals(type)&&d[1].equals(name))){bw.write(String.join(",",d));bw.newLine();}return true;}catch(Exception e){e.printStackTrace();return false;}}
 public String[] find(String type,String name){for(String[] d:all()) if(d[0].equals(type)&&d[1].equals(name))return d; return new String[]{type,name,"0"};}
}
