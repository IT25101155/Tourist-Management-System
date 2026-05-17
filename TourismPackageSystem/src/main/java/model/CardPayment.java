package model;
public class CardPayment extends Payment{public CardPayment(String id,String username,String bookingId,double amount,String status,String slipFile,String adminNote){super(id,username,bookingId,amount,"CARD",status,slipFile,adminNote);}@Override public boolean processPayment(){return getAmount()>0;}}
