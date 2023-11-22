import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../admin_components/available_room.dart';

class AllRooms extends StatefulWidget {
  const AllRooms({Key? key}) : super(key: key);

  @override
  State<AllRooms> createState() => _AllRoomsState();
}
class _AllRoomsState extends State<AllRooms> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;
  String roomno = '';
  String hotelname = '';
  String description = '';

  @override
  void initState() {
    stream =
        FirebaseFirestore.instance.collection('Available Rooms').snapshots();    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text('All Bookings',style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return AvailableRoomTile(
                  roomno: data['Room Number'],
                  hotelname: data['Hotel Name'],
                  description: data['Room Description'],
                );
              },
            );
          }
        },
      ),
    );
  }
}
