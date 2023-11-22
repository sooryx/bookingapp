import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyBookingPage extends StatefulWidget {
  const MyBookingPage({Key? key}) : super(key: key);

  @override
  _MyBookingPageState createState() => _MyBookingPageState();
}

class _MyBookingPageState extends State<MyBookingPage> {
  User? user = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  _fetchMyBookings() {
    stream = FirebaseFirestore.instance
        .collection('User Bookings')
        .doc(user!.uid)
        .collection("My Bookings")
        .snapshots();
  }

  void _deleteBooking(String roomNo) async {
    try {
      await FirebaseFirestore.instance
          .collection('User Bookings')
          .doc(user!.uid)
          .collection("My Bookings")
          .where('Room Number', isEqualTo: roomNo)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
      print('Booking deleted successfully: $roomNo');
      Fluttertoast.showToast(
          msg: "Booking Deleted ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 12.0);

    } catch (e) {
      print('Error deleting booking: $e');
    }
  }

  _confirmDeletion(String roomNo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "Are you sure ?",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            backgroundColor: Theme.of(context).colorScheme.onSurface,
            actions: [
              TextButton(
                onPressed: () async {
                  _deleteBooking(roomNo);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                  style:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
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
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black), // Change the drawer icon color here
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text('My Bookings',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings available.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                var roomNo = data['Room Number'];

                return Container(
                  padding: EdgeInsets.all(7.dg),
                  margin: EdgeInsets.all(10.dg),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.r)),
                  child: ListTile(
                    leading: Icon(Icons.house,size: 35.sp,),
                    title: Text(
                      'Room Number: ${data['Room Number']}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 14.sp),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            Text(
                              'Hotel Name: ',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp),
                            ),
                            Text('${data['Hotel Name']}',style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.normal,
                                fontSize: 16.sp)
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [

                            Expanded(
                              child: Text('${data['Room Description']}',textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.sp
                              ),),
                            )
                          ],
                        ),
                      ],
                    ),
                    trailing: Container(
                      padding: EdgeInsets.all(2.dg),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.3)),
                      child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            print('Deleting room number: $roomNo');
                            _confirmDeletion(roomNo);
                          }),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
