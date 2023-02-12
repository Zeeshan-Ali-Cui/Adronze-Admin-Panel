import 'package:adronzeadmin/views/Loginpage.dart';
import 'package:adronzeadmin/views/order.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async{
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDAfyQG6WXszaJxrqlBBVeCyLtom7NpVfo",
        authDomain: "dronze-b32e9.firebaseapp.com",
        projectId: "dronze-b32e9",
        storageBucket: "dronze-b32e9.appspot.com",
        messagingSenderId: "866021312489",
        appId: "1:866021312489:web:58f434dd0152e8c5a2ad78",
        measurementId: "G-ZP53745Y65"),
  );
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const loginpage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void initState() {
    super.initState();
    // add anything you need here
  }
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff29A9AB),
      body: SizedBox.expand(
        child: Row(

          children: [
            Container(width: size.width/5,
            child: Drawer(

              child: Container(
                color: Colors.white,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                        child: DecoratedBox(decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/logo.jpg"),)
                          // fit: BoxFit.cover)
                        ))),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: ListTile(
                          leading: Icon(Icons.person,color: Colors.white,),
                          title: Text('Order Detail',style: TextStyle(color: Colors.white),),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return MyHomePage();
                                }));
                          },
                        ),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: ListTile(
                          leading: Icon(Icons.logout,color: Colors.white,),
                          title: Text('Logout',style: TextStyle(color: Colors.white),),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return loginpage();
                                }));
                          },

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),),

            //else drawer
            Expanded(child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("All Orders",style: TextStyle(fontSize: 20,color: Colors.white),),
                  Divider(),
                  orderview(),
                ],
              ),
            ))

          ],
        ),
      ),

    );
  }
}