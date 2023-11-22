import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  String username = "";

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Fetch data from Firestore
        DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
            await FirebaseFirestore.instance
                .collection('Users')
                .doc(user.uid)
                .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic> userData = documentSnapshot.data()!;

          setState(() {
            username = userData['username'] ?? "Paproker";
          });

          // Set the username to the controller
          // UsernameController.text = username;
        }
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        username = "Paproker";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Container(
                  padding: EdgeInsets.all(10.dg),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.admin_panel_settings,
                            size: 50.sp,
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'Admin',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: _tohome,
                child: Padding(
                  padding: EdgeInsets.all(8.dg),
                  child: Container(
                    padding: EdgeInsets.all(5.dg),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: ListTile(
                      leading: Icon(Icons.home,
                        color: Theme.of(context).colorScheme.primary
                      ),
                      title: Text(
                        "Home",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),

              ///My Bookings
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/admin_all_rooms');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.dg),
                  child: Container(
                    padding: EdgeInsets.all(5.dg),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: ListTile(
                      leading: Icon(Icons.room_preferences,
                        color: Theme.of(context).colorScheme.primary
                      ),
                      title: Text(
                        "All Rooms",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),

              ///PROFILE
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/user_list');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.dg),
                  child: Container(
                    padding: EdgeInsets.all(5.dg),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r)),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Theme.of(context)
                            .colorScheme
                            .primary),
                      title: Text(
                        "List Of Users",
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, "/admin_login");
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 15.h, left: 8.w, right: 8.w),
              child: Container(
                padding: EdgeInsets.all(5.dg),
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r)),
                child: ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _tohome() {
    Navigator.pushNamed(context, '/admin_home');
  }
}
