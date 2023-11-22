import 'package:booking/user/components/available_room_for_user.dart';
import 'package:booking/user/components/my_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../auth/firebase_auth/firebase_auth_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../components/my_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      drawer: MyDrawer(),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              color: Colors.white,
              margin: EdgeInsets.only(top: 250.h),
            ),
            Column(
              children: [_HeadingSection(), _SearchCard(), _NearByHotels()],
            )
          ],
        ),
      ),
    );
  }
}

class _HeadingSection extends StatelessWidget {
  const _HeadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.5)),
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.all(10.dg),
              child: Text(
                'Welcome !',
                style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
        ],
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({super.key});

  @override
  Widget build(BuildContext context) {
    final locationController = TextEditingController();
    final dateFromController = TextEditingController();
    final dateToController = TextEditingController();

    dateFromController.text = dateToController.text =
        DateFormat('dd MMM yyyy').format(DateTime.now());
    locationController.text = 'Bangalore';

    Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );

      if (pickedDate != null && pickedDate != DateTime.now()) {
        String formattedDate = DateFormat('dd MMM yyyy').format(pickedDate);
        controller.text = formattedDate;
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.dg),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: TextField(enabled: false,
                    controller: locationController,
                    decoration: InputDecoration(
                      label: Text(
                        'Location',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(5.dg),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: TextFormField(
                    controller: dateFromController,
                    readOnly: true,
                    onTap: () => _selectDate(context, dateFromController),
                    decoration: InputDecoration(
                      label: Text(
                        'From',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.dg),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                  child: Icon(
                    Icons.calendar_month,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  child: TextFormField(
                    controller: dateToController,
                    readOnly: true,
                    onTap: () => _selectDate(context, dateToController),
                    decoration: InputDecoration(
                      label: Text(
                        'To',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Divider(),
            MyButton(
              title: 'Search',
              onTap: () {
                Navigator.pushNamed(context, '/search_page');
              },
            )
          ],
        ),
      ),
    );
  }
}

class _NearByHotels extends StatefulWidget {
  const _NearByHotels({super.key});

  @override
  State<_NearByHotels> createState() => _NearByHotelsState();
}

class _NearByHotelsState extends State<_NearByHotels> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  String username = '';
  String emailid = '';
  String roomno = '';
  String hotelname = '';
  String description = '';
  User? user = FirebaseAuth.instance.currentUser;
  late Stream<QuerySnapshot<Map<String, dynamic>>> stream;

  _fetchMyBookings() async {
    var userDoc = await FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.uid)
        .get();

    if (userDoc.exists) {
      // The document exists, and you can access its data
      var userData = userDoc.data();
      if (userData != null) {
        print('Username: ${userData['username']}');
        print('Email: ${userData['email']}');
        setState(() {
          username = ' ${userData['username']}';
          emailid = ' ${userData['email']}';
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
      'User Name': username,
      'Email ID': emailid
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

  void _confirmBooking(
      String roomNo, String hotelName, String description) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              "Confirm Booking ?",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            icon: Icon(
              Icons.check,
              color: Colors.green,
            ),
            backgroundColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () async {
                  _bookRoom(roomNo, hotelName, description);
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
    _fetchMyBookings();
    super.initState();
    stream =
        FirebaseFirestore.instance.collection('Available Rooms').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    final locationController = TextEditingController();
    final datefromTextController = TextEditingController();
    final datetoTextController = TextEditingController();

    datefromTextController.text = datetoTextController.text =
        DateFormat('dd MMM yyyy').format(DateTime.now());
    locationController.text = 'Bangalore';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top Rated Hotel",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/search_page');
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          StreamBuilder(
            stream: stream,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No rooms available.",
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: 1,
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
        ],
      ),
    );
  }
}
