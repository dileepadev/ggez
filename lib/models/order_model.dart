import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String contactAddress;
  String contactCity;
  String contactEmail;
  String contactFirstName;
  String contactLastName;
  String contactNumber;
  String deliveryAddress;
  String deliveryCity;
  String itemID;
  String itemName;
  int itemQuantity;
  String itemSize;
  String itemType;
  int itemUnitPrice;
  String orderDate;
  String orderID;
  String paymentID;
  int totalAmount;
  String userID;

  OrderModel({
    required this.contactAddress,
    required this.contactCity,
    required this.contactEmail,
    required this.contactFirstName,
    required this.contactLastName,
    required this.contactNumber,
    required this.deliveryAddress,
    required this.deliveryCity,
    required this.itemID,
    required this.itemName,
    required this.itemQuantity,
    required this.itemSize,
    required this.itemType,
    required this.itemUnitPrice,
    required this.orderDate,
    required this.orderID,
    required this.paymentID,
    required this.totalAmount,
    required this.userID,
  });

  factory OrderModel.fromJsom(DocumentSnapshot snapshot) {
    return OrderModel(
      contactAddress: snapshot['contactAddress'],
      contactCity: snapshot['contactCity'],
      contactEmail: snapshot['contactEmail'],
      contactFirstName: snapshot['contactFirstName'],
      contactLastName: snapshot['contactLastName'],
      contactNumber: snapshot['contactNumber'],
      deliveryAddress: snapshot['deliveryAddress'],
      deliveryCity: snapshot['deliveryCity'],
      itemID: snapshot['itemID'],
      itemName: snapshot['itemName'],
      itemQuantity: snapshot['itemQuantity'],
      itemSize: snapshot['itemSize'],
      itemType: snapshot['itemType'],
      itemUnitPrice: snapshot['itemUnitPrice'],
      orderDate: snapshot['orderDate'],
      orderID: snapshot['orderID'],
      paymentID: snapshot['paymentID'],
      totalAmount: snapshot['totalAmount'],
      userID: snapshot['userID'],
    );
  }
}
