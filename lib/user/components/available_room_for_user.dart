import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableRoomTileForUser extends StatefulWidget {
  final String roomno;
  final String hotelname;
  final String description;
  final VoidCallback? onBookNowPressed;

  AvailableRoomTileForUser({
    Key? key,
    required this.roomno,
    required this.hotelname,
    required this.description,
    this.onBookNowPressed,
  }) : super(key: key);

  @override
  _AvailableRoomTileForUserState createState() =>
      _AvailableRoomTileForUserState();
}

class _AvailableRoomTileForUserState extends State<AvailableRoomTileForUser> {
  // Add a variable to store the selected number of guests
  int selectedGuests = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      margin: EdgeInsets.all(25.dg),
      padding: EdgeInsets.all(15.dg),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'Room No:',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      widget.roomno,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.favorite,
                color: Colors.red,
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                widget.hotelname,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///DESCRIPTION
          Center(
            child: Container(
              child: Text(
                widget.description,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///NO OF GUESTS
          Container(
            width: 220.w,
            padding: EdgeInsets.all(10.dg),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(width: 0.4, color: Colors.black54)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Number of Guests:',
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(width: 10.w),
                // Dropdown button for selecting the number of guests
                DropdownButton<int>(
                  value: selectedGuests,
                  items: List.generate(10, (index) => index + 1)
                      .map((guests) => DropdownMenuItem<int>(
                            value: guests,
                            child: Text(guests.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    // Update the selected number of guests using setState
                    setState(() {
                      selectedGuests = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),

          ///BOOK_NOW
          Center(
            child: GestureDetector(
              onTap: widget.onBookNowPressed,
              child: Container(
                height: 60.h,
                width: 180.w,
                padding: EdgeInsets.all(10.dg),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.r),
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                child: Center(
                  child: Text(
                    "Book Now",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
