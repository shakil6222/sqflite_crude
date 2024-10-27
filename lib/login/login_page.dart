import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_crude/database_helper.dart';
import 'package:sqflite_crude/home_page.dart';
import 'package:sqflite_crude/login/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final DataBaseHelper dbHelper = DataBaseHelper();
  var loginEmail1 = TextEditingController();
  var loginPassword1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 120, left: 20, bottom: 20),
            child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 1,
                child: const Text(
                  'Login Page',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                      fontStyle: FontStyle.italic),
                )),
          ),
          Container(
              height: 450,
              width: 350,
              decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(width: 2, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(20)),
              child: ListView(
                children: [
                  const Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          foregroundImage:
                              AssetImage("assets/images/about - Copy.jpg"),
                          radius: 50,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: loginEmail1,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Enter Your Email",
                            prefixIcon: Icon(Icons.email),
                            fillColor: Colors.red,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: loginPassword1,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          autocorrect: true,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            hintText: "Enter Email Password",
                            prefixIcon: Icon(Icons.lock),
                            hintMaxLines: 6,
                            fillColor: Colors.red,
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: const Text("Forgot Password?"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignupPage()));
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.grey),
                              ),
                              onPressed: () {
                                loginUser();
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
  void loginUser() async {
    var loginEmailId = loginEmail1.text.toString();
    var loginPassword = loginPassword1.text.toString();
    if(loginEmailId.isNotEmpty && loginPassword.isNotEmpty){
      Map <String, dynamic>  loginData = {
        "userName" : loginEmailId,
        "userEmail" : loginPassword,
        'islogin': 0,
      };
      int results = await dbHelper.signupNewUser(loginData);

      if(results > 0){
        Fluttertoast.showToast(msg: "Login successful!");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false,);
      }else{
        Fluttertoast.showToast(msg: "Login Not successful!");
      }
    }else{
      Fluttertoast.showToast(msg: "fill in all blanks");
    }

  }
}
