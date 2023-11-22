import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../auth/firebase_auth/firebase_auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfields.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/admin_login');
              },
              child: Text(
                "Admin",
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(25.dg),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 80.sp,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  " K O D S ",
                  style: TextStyle(fontSize: 20.sp),
                ),
                SizedBox(
                  height: 50.h,
                ),
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController),
                SizedBox(
                  height: 10.h,
                ),
                MyTextField(
                    hintText: "Password",
                    obscureText: true,
                    controller: passwordController),

                SizedBox(
                  height: 20.h,
                ),
                MyButton(
                  title: "Login",
                  onTap: _signIn,
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          " Register Here",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print("Login Completed");
      _tohome();
    } else {
      print("Try again");
    }
  }

  void _tohome() {
    Fluttertoast.showToast(
        msg: "Welcome Onboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0);
    Navigator.pushNamed(context, '/home');
  }
}
