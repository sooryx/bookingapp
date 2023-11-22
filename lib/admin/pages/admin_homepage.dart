import 'package:booking/admin/admin_components/add_rooms.dart';
import 'package:booking/admin/admin_components/available_room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../admin_components/admin_drawer.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("A D M I N",style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
        centerTitle: true,
      ),
      drawer: AdminDrawer(),
      body: SingleChildScrollView(
        child: Column(

          children: [
            AddRooms(),
          ],
        ),
      ),
    );
  }
}
