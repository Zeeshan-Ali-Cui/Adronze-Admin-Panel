
import 'dart:ui';


import 'package:adronzeadmin/models/ordermodel.dart';
import 'package:adronzeadmin/services/notify.dart';
import 'package:adronzeadmin/services/orderservices.dart';
import 'package:adronzeadmin/views/orderdetailview.dart';
import 'package:flutter/material.dart';

class orderview extends StatefulWidget {
  const orderview({Key? key}) : super(key: key);

  @override
  State<orderview> createState() => _orderviewState();
}

class _orderviewState extends State<orderview> {
  List<listof_orderlist> listoforder = [];

  bool loading = true;

  orderlist listord = orderlist([]);

  void getorders() async {
    try {
      var ord = await placeOrderService()
          .getorder();

      orderlist ls = orderlist([]);

      for(var useror in ord){
      for(var order in useror.orders!.orders!) {
        ls.orders!.add(order);
      }
      }

      ls.orders!.sort((a,b){
        return DateTime.fromMicrosecondsSinceEpoch(int.parse(b.id!)).compareTo(DateTime.fromMicrosecondsSinceEpoch(int.parse(a.id!)));
      });
      setState(() {
        listord = ls;
      });

      // ord.sort((a,b){
      //   return DateTime.fromMicrosecondsSinceEpoch(a.)
      // });
      setState(() {
        listoforder = ord;
      });
    } catch (e) {}
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      getorders();
    });
  }

   List<String> list_status = <String>["enqueue", 'dispatch', 'Complete', 'Cancle'];
   List<String> pay_status = <String>["Payment in progress", 'Payment Sucessful'];

  @override
  Widget build(BuildContext context) {


    return
     loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : listoforder!.length == 0
                ? Center(
                    child: Text("Not Order any item yet"),
                  )
                : ListView.builder(
             physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listord.orders!.length,
            itemBuilder: (c,j){
              var order = listord.orders![j];
              String vale_of_dd = order.status == 0 ? "enqueue":order.status == 1 ? 'dispatch':
              order.status == 2 ? 'Complete': 'Cancle';

              String value_pay_dd = order.payment == 0?"Payment in progress":'Payment Sucessful';
              return
             Card(
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(20.0),
               ),
               elevation: 50,
               shadowColor: Color(0xff29A9AB),
               margin: EdgeInsets.all(40),
               child: SizedBox(
                 height: 120,
                 child: Row(
                   children: [
                     InkWell(
                       onTap: (){
                         Navigator.of(context)
                             .push(MaterialPageRoute(builder: (BuildContext contex)
                         {
                           return orderdetailview(order: order,);
                         }));
                       },
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Text(
                             "  Name: " + order.name!.toString(),
                             style: TextStyle(fontSize: 15),
                             textAlign: TextAlign.start,
                           ),
                           Text(
                             "  Order Id: " + order.id!.toString(),
                             style: TextStyle(fontSize: 15),
                             textAlign: TextAlign.start,
                           ),
                           Text(
                             "  Total Products: " +
                                 order.products!.length.toString(),
                             style: TextStyle(fontSize: 15),
                             textAlign: TextAlign.start,
                           ),
                           Text(
                             "  Latitude: " +
                                 order.lat.toString(),
                             style: TextStyle(fontSize: 15),
                             textAlign: TextAlign.start,
                           ),
                           Text(
                             "  Longitude: " +
                                 order.long.toString(),
                             style: TextStyle(fontSize: 15),
                             textAlign: TextAlign.start,
                           ),
                         ],
                       ),
                     ),

                     Spacer(),
                     Column(
                       children: [
                         DropdownButton<String>(
                           value: vale_of_dd,
                           icon:  Icon(Icons.arrow_downward,color: Color(0xff29A9AB),),
                           elevation: 16,
                           style: TextStyle(color: Colors.cyan),
                           underline: Container(
                             height: 2,
                             color: Colors.black,
                           ),
                           onChanged: (String? value)async {
                             // This is called when the user selects an item.
                             setState(() {
                               loading = true;
                             });
                             int vale_of_order_status = value == "enqueue" ? 0:value == 'dispatch' ? 1:
                             value == 'Complete' ? 2: 3;
                             String uid = "";
                             for(var orders in listoforder){
                               for(var or in orders.orders!.orders!){
                                 if(or.id == order.id){
                                   uid = orders.uid!;
                                 }
                               }
                             }
                             var orderserv = placeOrderService();
                                await
                             orderserv.changeorder_status(
                                 uid, order.id!, vale_of_order_status);
                             getorders();
                             setState(() {
                               loading = false;
                               // vale_of_dd = value!;
                             });
                             Notify notify=Notify();
                             notify.notifyOrderStatus(uid,order,vale_of_order_status);


                           },
                           items: list_status.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text("Order Status : "+ value),
                             );
                           }).toList(),
                         ),
                         DropdownButton<String>(
                           value: value_pay_dd,
                           icon:  Icon(Icons.arrow_downward,color: Color(0xff29A9AB),),
                           elevation: 16,
                           style: TextStyle(color: Colors.cyan),
                           underline: Container(
                             height: 2,
                             color: Colors.black,
                           ),
                           onChanged: (String? value)async {
                             // This is called when the user selects an item.
                             setState(() {
                               loading = true;
                             });
                             int vale_of_pay_status = value == "Payment in progress"? 0:1;
                             String uid = "";
                             for(var orders in listoforder){
                               for(var or in orders.orders!.orders!){
                                 if(or.id == order.id){
                                   uid = orders.uid!;
                                 }
                               }
                             }
                             var orderserv = placeOrderService();
                             await
                             orderserv.changeorder_payment_status(
                                 uid, order.id!, vale_of_pay_status);
                             getorders();
                             setState(() {
                               loading = false;
                               // vale_of_dd = value!;
                             });



                           },
                           items: pay_status.map<DropdownMenuItem<String>>((String value) {
                             return DropdownMenuItem<String>(
                               value: value,
                               child: Text("Payment Status : "+ value),
                             );
                           }).toList(),
                         )
                       ],
                     ),

                   ],
                 ),
               ),

             );}
          );


  }
}
