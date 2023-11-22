import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddRooms extends StatefulWidget {
  const AddRooms({
    super.key,
  });

  @override
  State<AddRooms> createState() => _AddRoomsState();
}

class _AddRoomsState extends State<AddRooms> {
  DateTime selectedDate = DateTime.now();
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }

  User? user = FirebaseAuth.instance.currentUser;

  _storeData() async {
    await FirebaseFirestore.instance
        .collection('Available Rooms')
        .add({
      'Room Number': roomNumberController.text,
      'Hotel Name': hotelNameController.text,
      'Room Description': descriptionController.text,
      'Date':DateTime.now().toString()
    });
    Fluttertoast.showToast(
        msg: "Room Added",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 12.0);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25.dg),
      margin: EdgeInsets.all(25.dg),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Add Rooms",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.all(25.dg),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(
              children: [
                Icon(
                  Icons.alternate_email,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextField(
                    controller: hotelNameController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Hotel Name',
                      // hintStyle:
                      //     TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.all(25.dg),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(
              children: [
                Icon(
                  Icons.numbers,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextField(
                    controller: roomNumberController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Room Number',
                      // hintStyle:
                      //     TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            padding: EdgeInsets.all(25.dg),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 1, color: Colors.black)),
            child: Row(
              children: [
                Icon(
                  Icons.description,
                  size: 30.sp,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Description',
                      // hintStyle:
                      //     TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              _storeData();
            },
            child: Container(
                height: 60.h,
                width: 180.w,
                padding: EdgeInsets.all(10.dg),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.r),
                    color: Theme.of(context).colorScheme.inversePrimary),
                child: Center(
                  child: Text(
                    "Add Rooms",
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
