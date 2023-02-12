import 'package:adronzeadmin/models/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class orderdetailview extends StatefulWidget {
  orderm? order;
  orderdetailview({Key? key,this.order}) : super(key: key);

  @override
  State<orderdetailview> createState() => _orderdetailviewState();
}

class _orderdetailviewState extends State<orderdetailview> {

  bool loading_loc = true;
  String order_Loc = "";
  // Future<void> saveLocation() async {
  //
  //   await placemarkFromCoordinates(
  //       double.parse(widget.order!.lat.toString()), double.parse(widget.order!.long.toString()))
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       print(" ");
  //       order_Loc =
  //       '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
  //       loading_loc = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // saveLocation();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Order Detail"),
      backgroundColor: Color(0xff29A9AB),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.cyan[100],
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.only(left: 5,right: 5,top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(border: Border.all(color: Colors.cyan),color: Colors.white,borderRadius: BorderRadius.circular(12),),
                padding: const EdgeInsets.all(8.0),
                child: Text("Person Name: "+widget.order!.name.toString(),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(border: Border.all(color: Colors.cyan),color: Colors.white,borderRadius: BorderRadius.circular(12),),

                padding: const EdgeInsets.all(16.0),
                child: Text('Location : ${widget.order!.address! == "" ?  "Loading":widget.order!.address!}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Divider(),
              Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(border: Border.all(color: Colors.cyan),color: Colors.white,borderRadius: BorderRadius.circular(12),),
                padding: const EdgeInsets.all(16.0),
                child: Text( "Order status: " +
                    "${widget.order!.status == 0 ? "in queue" : widget.order!.status == 1 ? "Dispatched" : "Completed"}"
                    ,
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 5,),
              Center(child: Text("Products List",style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)),
              SizedBox(height: 5,),

              Expanded(
                child: ListView.builder(
                    itemCount: widget.order!.products!.length ,
                    itemBuilder: (c,i){
                      var item = widget.order!.products![i];
                      return
                        Card(
                            child: ListTile(title: Text(item!.name.toString()),
                              // trailing: InkWell(child: Icon(Icons.remove_circle_outline_sharp, color: Colors.cyan,),
                              //   onTap: ()async{
                              //   },
                              // ),
                            )
                        );
                }),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
