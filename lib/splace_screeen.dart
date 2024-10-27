
import 'package:flutter/material.dart';
import 'package:sqflite_crude/database_helper.dart';
import 'package:sqflite_crude/login/signup_page.dart';

class SplaceScreen extends StatefulWidget {
  const SplaceScreen({super.key, required String title});

  @override
  State<SplaceScreen> createState() => _SplaceScreenState();
}

class _SplaceScreenState extends State<SplaceScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5),() {
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SignupPage()), (route) => false,);
    },);

  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.orange.shade500,
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.orange,
                          radius: 50.0,
                          child:ClipOval(
                            child: Image.asset("assets/images/u_udan_logo.webp",fit: BoxFit.cover, height: 100,width: 100,),

                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "SqfLite",
                            style: TextStyle(
                                color: Colors.black, fontSize: 32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    child:
                    Text(
                      "This is SqfLite Crude \n 2024",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22, color: Colors.black),
                    )
                    ,
                  )
                  //   people
                ],
              ),
            ),
          ],
        ),
      );
  }

  void loginStates() async {
    DataBaseHelper helper = await DataBaseHelper();


  }
}
