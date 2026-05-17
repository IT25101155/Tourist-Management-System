package model;
public class OnlinePayment extends Payment{public OnlinePayment(String id,String username,String bookingId,double amount,String status,String slipFile,String adminNote){super(id,username,bookingId,amount,"ONLINE",status,slipFile,adminNote);}@Override public boolean processPayment(){return getAmount()>0;}}
