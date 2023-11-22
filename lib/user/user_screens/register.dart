import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../auth/firebase_auth/firebase_auth_services.dart';
import '../components/my_button.dart';
import '../components/my_textfields.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({Key? key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  bool confirmpass = false;



  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background ,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                "Admin",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(25.dg),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50.h,
                width: 50.w,
                child: Image.asset('assets/images/logos/logo-nobg.png'),
              ),
              SizedBox(
                height: 25.h,
              ),
              Text(
                "K O D S    B O O K I N G ",
                style: TextStyle(fontSize: 20.sp),
              ),
              SizedBox(
                height: 50.h,
              ),
              MyTextField(
                  hintText: "Name",
                  obscureText: false,
                  controller: usernameController,
              icon: Icon(Icons.person_2_outlined),),
              SizedBox(
                height: 10.h,
              ),
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
              icon: Icon(Icons.email_outlined),),
              SizedBox(
                height: 10.h,
              ),
              MyTextField(
                hintText: 'Enter Password',
                obscureText: true,
                controller: passwordController,
                icon: Icon(Icons.lock),
              ),
              SizedBox(
                height: 20.h,
              ),
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: confirmpasswordController,
                icon: Icon(Icons.lock),
              ),
              SizedBox(height: 10.h,),
              confirmpass
                  ? Text("Password do not match with each other ",
                style: TextStyle(color: Colors.red),)
                  : SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              MyButton(
                title: "Register",
                onTap: () {
                  if (passwordController.text ==
                      confirmpasswordController.text) {
                   _signUp();

                  } else {
                    setState(() {
                      confirmpass =true;
                    });

                  }
                },
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
                  Text("Already have an account ?"),
                  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        " Login Here",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepPurple),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;


    User? user = await _auth.signUpWithEmailAndPassword(
      username,
      email,
      password,
    );

    if (user != null) {
      print('navigating to home');

      _tohome();
    } else {
      print('not navigating to home');

      Fluttertoast.showToast(
        msg: "Some Error Occured",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 12.0,
      );
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
      fontSize: 12.0,
    );
    Navigator.pushNamed(context, '/home');
  }
}
