import 'dart:convert';
import 'package:adronzeadmin/models/ordermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';

class Notify{
  Future<void> notifyUser(
      String? userToken) async {
    String payload = jsonEncode({
      'to': userToken,
      'notification': {'title':'Your order is updated!','body':'Tap to view!'},
      'data': { 'type': '1'}
    });
    // notify
    try {
      await  post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":
          "key=AAAAyaLkh-k:APA91bFlRVhZCrU7rGjRrpdEzGtbNQAYuwfDLbvXm9Jq_f1s2hZKUCkywS-cWw8fh6_W4gt23auXBMzETcSbgco1ZRuzIvT2FW8UxhS03LqjV9-PFJO3u84Kh_RkGIEiQhE6TnnC4TnY"
        },
        body: payload,
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  notifyOrderStatus(String uid, orderm order,int status)async{
    DocumentSnapshot ds=await FirebaseFirestore.instance.collection('Tokens').doc(uid!).get();
    if(ds.exists) {
      notifyUser((ds.data() as Map)['Token']);
      await FirebaseFirestore.instance.collection('Notifications').add({
        'uid':uid,
        'order':order.toJson(),
        'status':status,
        'at':DateTime.now()
      });
    }
  }
}