import 'package:adronzeadmin/models/cartmodel.dart';
import 'package:adronzeadmin/models/ordermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class placeOrderService {
  Future<bool> changeorder_status(
      String? uid, String orderid, int status ) async {
    try {
      orderlist orders = orderlist([]);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        var col = await firestore.collection("Orders").doc(uid).get();
        if (col != null) {
          orders = orderlist.fromjson(col.data() as Map<String, dynamic>);
        }
      } catch (e) {}
      //add new product
      for (int i = 0; i < orders.orders!.length; i++) {
        if (orders.orders![i].id == orderid) {
          orders.orders![i].status = status;
        }
      }

      //empty cart
      await firestore.collection("Orders").doc(uid).set(orders.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> changeorder_payment_status(
      String? uid, String orderid, int pay ) async {
    try {
      orderlist orders = orderlist([]);
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        var col = await firestore.collection("Orders").doc(uid).get();
        if (col != null) {
          orders = orderlist.fromjson(col.data() as Map<String, dynamic>);
        }
      } catch (e) {}
      //add new product
      for (int i = 0; i < orders.orders!.length; i++) {
        if (orders.orders![i].id == orderid) {
          orders.orders![i].payment= pay;
        }
      }

      //empty cart
      await firestore.collection("Orders").doc(uid).set(orders.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<listof_orderlist>> getorder() async {
    List<listof_orderlist> orders = [];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      try {
        var col = await firestore.collection("Orders").get();
        if (col != null) {
          for (var data in col.docs)
            orders.add(listof_orderlist(orderlist.fromjson(
                data.data() as Map<String, dynamic>), data.id.toString()));
        }
      } catch (e) {}

      return orders;
    } catch (e) {
      return orders;
    }
  }
}
