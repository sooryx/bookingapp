import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfUsers extends StatefulWidget {
  const ListOfUsers({Key? key}) : super(key: key);

  @override
  State<ListOfUsers> createState() => _ListOfUsersState();
}

class _ListOfUsersState extends State<ListOfUsers> {
  late User user;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      if (user != null) {
        // Fetch data from Firestore collection
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();

        if (querySnapshot.docs.isNotEmpty) {
          List<Map<String, dynamic>> userList = [];
          for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in querySnapshot.docs) {
            Map<String, dynamic> userData = documentSnapshot.data();
            userList.add(userData);
          }

          setState(() {
            users = userList;
          });
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("List Of Users",style: TextStyle(color:Theme.of(context).colorScheme.secondary,
        ),),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display the list of users using a ListView
          if (users.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10.dg),
                    margin: EdgeInsets.all(10.dg),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black54,
                      )
                    ),
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'User Name: ${users[index]['username'] ?? ''}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Email: ${users[index]['email'] ?? ''}'),
                      // Add more fields as needed
                    ),
                  );
                },
              ),
            ),
          if (users.isEmpty) Center(child: Column(
            children: [
              Icon(Icons.sentiment_dissatisfied,size: 50.sp,),
              SizedBox(height: 40.h,),
              Text("No users Registered"),
            ],
          ))
        ],
      ),
    );
  }
}
