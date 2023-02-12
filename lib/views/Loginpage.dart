import 'package:adronzeadmin/main.dart';
import 'package:flutter/material.dart';
class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: Container(
        height: 800,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/map.jpg"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Color(0xff29A9AB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 50,
              shadowColor: Color(0xff29A9AB),
              child: SizedBox(
                width: 600,
                height: 550,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    Container(
                        width: 120,
                        margin: EdgeInsets.all(30),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              child: Image.asset('assets/images/logo.jpg'),
                            )
                        )
                    ),
                    Container(
                      child: Text("Welcome Admin",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),),
                    ),
                    Container(
                      child: Text("Please Enter Username And Password",
                        style:TextStyle(fontSize: 10,fontWeight: FontWeight.w200,color: Colors.white) ,),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 3, color: Colors.cyan), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Username',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: ( Padding(
                                  padding: EdgeInsets.all(32.0),
                            child: TextField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(width: 3, color: Colors.cyan), //<-- SEE HERE
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                              filled: true,
                              fillColor: Colors.white,
                            labelText: 'Password',
                            ))))),
                    Container(
                      margin: EdgeInsets.all(25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, //background color of button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            padding: EdgeInsets.all(20)
                        ),
                        child: Text(
                          'LogIn',
                          style: TextStyle(fontSize: 20.0,color: Colors.cyan),
                        ),
                        onPressed: () {
                          if (nameController.text=="admin" && passwordController.text=="admin"){
                            // print("login sucessful");
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Sucessful")));
                                Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                return MyHomePage();

                                }));
                          } else
                          {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Login Failed")));
                            // print("Login Failed");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
