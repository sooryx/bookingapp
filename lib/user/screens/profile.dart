import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../components/my_textfields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String emailid = "";

  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  User? user = FirebaseAuth.instance.currentUser;

  _fetchMyBookings() async{
    var userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    if (userDoc.exists) {
      // The document exists, and you can access its data
      var userData = userDoc.data();
      if(userData!=null) {
        print('Username: ${userData['username']}');
        print('Email: ${userData['email']}');
        setState(() {
          username =  ' ${userData['username']}';
          emailid =  ' ${userData['email']}';

        });
      } else {
        // User does not exist
        print('User does not exist');
        Fluttertoast.showToast(
            msg: "User does not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 12.0);

      }
    }
  }


  @override
  void initState() {
    _fetchMyBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black), // Change the drawer icon color here
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 6,
        title: Text('Profile',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 30.h,
            ),
            Container(
              padding: EdgeInsets.all(25.dg),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3)),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 50.sp,
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            MyTextField(
              hintText: username,
              icon: Icon(Icons.abc_rounded),
              obscureText: false,
              controller: editNameController,
            ),
            SizedBox(
              height: 20.h,
            ),
            MyTextField(
                hintText: emailid,
                icon: Icon(Icons.mail_outline_rounded),
                obscureText: false,
                controller: editEmailController),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
