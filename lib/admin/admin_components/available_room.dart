import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableRoomTile extends StatelessWidget {
  final String roomno;
  final String hotelname;
  final String description;
  const AvailableRoomTile({
    super.key, required this.roomno, required this.hotelname, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 350.w,
          margin: EdgeInsets.all(25.dg),
          padding: EdgeInsets.all(15.dg),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onError,
                        borderRadius: BorderRadius.circular(50.r)),
                    child: Row(
                      children: [
                        Text('Room No:',style: TextStyle(fontSize: 14.sp),),
                        Text(
                          roomno,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      hotelname,
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 250.w,
                  child: Text(
                description,
                style: TextStyle(fontSize: 16.sp),
              )),
              // GestureDetector(
              //   onTap: () {},
              //   child: Container(
              //       height: 60.h,
              //       width: 180.w,
              //       padding: EdgeInsets.all(10.dg),
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(40.r),
              //           color:
              //               Theme.of(context).colorScheme.inversePrimary),
              //       child: Center(
              //         child: Text(
              //           "Book Now",
              //           style: TextStyle(
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.bold,
              //               color: Theme.of(context).colorScheme.primary),
              //         ),
              //       )),
              // )
            ],
          )
    );
  }
}
