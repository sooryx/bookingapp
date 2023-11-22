import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../auth/firebase_auth/firebase_auth_services.dart';
import '../../user/components/my_button.dart';
import '../../user/components/my_textfields.dart';

class AdminLoginPage extends StatefulWidget {
  AdminLoginPage({
    super.key,
  });

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
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
                Navigator.pushNamed(context, '/user_login_or_reg');
              },
              child: Text(
                "User",
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
                  Icons.admin_panel_settings_outlined,
                  size: 80.sp,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  "A D M I N",
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
                  height: 10.h,
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
      _toAdminhome();
    } else {
      print("Try again");
    }
  }

  void _toAdminhome() {
    Fluttertoast.showToast(
        msg: "Welcome Onboard",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0);
    Navigator.pushNamed(context, '/admin_home');
  }
}
