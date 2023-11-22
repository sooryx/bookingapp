import 'package:booking/user/components/available_room_for_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../auth/firebase_auth/firebase_auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/my_drawer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  String username ='';
  String emailid ='';
  String roomno = '';
  String hotelname = '';
  String description = '';
  User? user = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  _fetchMyBookings() async{
    var userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    if (userDoc.exists) {
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

  void _bookRoom(String roomNo, String hotelName, String description) async {
    // Add to User Bookings
    await FirebaseFirestore.instance
        .collection('User Bookings')
        .doc(user!.uid)
        .collection("My Bookings")
        .add({
      'Room Number': roomNo,
      'Hotel Name': hotelName,
      'Room Description': description,
      'User Name':username,
      'Email ID':emailid
    });

    // Remove from Available Rooms
    await FirebaseFirestore.instance
        .collection('Available Rooms')
        .where('Room Number', isEqualTo: roomNo)
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    Fluttertoast.showToast(
        msg: "Room Booked Successfully !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  void _confirmBooking(String roomNo, String hotelName, String description) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "Confirm Booking ?",
              style: TextStyle(color: Theme
                  .of(context)
                  .colorScheme
                  .secondary),
            ),
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
            backgroundColor:Colors.white,
            actions: [
              TextButton(
                onPressed: () async {
                  _bookRoom(roomNo,hotelName,description);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                  style:
                  TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Cancel deletion
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style:
                  TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .primary),
                ),
              ),
            ],
          );
        });
  }
  @override
  void initState() {
    _fetchMyBookings();
    super.initState();
    stream =
        FirebaseFirestore.instance.collection('Available Rooms').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black), // Change the drawer icon color here
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: stream,
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if(snapshot.data!.docs.isEmpty){
                    return Center(
                      child: Text(
                        "No rooms available.",
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                        return AvailableRoomTileForUser(
                          roomno: data['Room Number'],
                          hotelname: data['Hotel Name'],
                          description: data['Room Description'],
                          onBookNowPressed: () {
                            _confirmBooking(
                              data['Room Number'],
                              data['Hotel Name'],
                              data['Room Description'],
                            );
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
