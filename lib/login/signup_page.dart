import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite_crude/database_helper.dart';
import 'package:sqflite_crude/login/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final DataBaseHelper dbHelpers = DataBaseHelper();
  var userName = TextEditingController();
  var userEmail = TextEditingController();
  var userPass = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 18, bottom: 20),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 1,
                  child: const Text(
                    'SignUp Page',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontStyle: FontStyle.italic),
                  )),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  height: 550,
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
                              controller: userName,
                              keyboardType: TextInputType.name,
                              textAlign: TextAlign.start,
                              autocorrect: true,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Enter Your Name",
                                prefixIcon: Icon(Icons.person),
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
                              controller: userEmail,
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
                              controller: userPass,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start,
                              autocorrect: true,
                              style: const TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Enter Email Password",
                                prefixIcon: Icon(Icons.email),
                                fillColor: Colors.red,
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
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
                                    signUpUser();
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
                  )),
            )
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    var signUpName = userName.text.toString();
    var signUpEmail = userEmail.text.toString();
    var signUpPassword = userPass.text.toString();
    if (signUpName.isNotEmpty &&
        signUpEmail.isNotEmpty &&
        signUpPassword.isNotEmpty) {
      Map<String, dynamic> userData = {
        'userName': signUpName,
        'userEmail': signUpEmail,
        'userPassword': signUpPassword,
        'islogin': 0, // 0 for not logged in
      };
      dbHelpers.signupNewUser(userData);
      int result = await dbHelpers.signupNewUser(userData);

      if (result > 0) {
        Fluttertoast.showToast(msg: "Signup successful!");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      } else {
        Fluttertoast.showToast(msg: "Signup Not successful!");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill in all fields.");
    }
  }
}
