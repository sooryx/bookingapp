import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:booking/auth/login_or_register.dart';
import 'package:booking/user/user_screens/booking_page.dart';
import 'package:booking/user/user_screens/profile.dart';
import 'package:booking/user/user_screens/search_page.dart';
import 'package:booking/user/user_screens/user_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'admin/admin_screens/admin_homepage.dart';
import 'admin/admin_screens/admin_login.dart';
import 'admin/admin_screens/all_bookings.dart';
import 'admin/admin_screens/list_of_users.dart';
import 'firebase_options.dart';
import 'onboarding_screen/onboarding_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    print("screen width is $screenWidth");
    print("screen height is $screenHeight");

    ///ScreenUtil is added to make the app responsive

    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 850.9090909090909),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // home:AvailableRoomTile(),
            home: AnimatedSplashScreen(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                animationDuration: Duration(milliseconds: 1000),
                splash: Image.asset(filterQuality: FilterQuality.high,
                  'assets/images/logos/logo-bg-light.png',
                ),splashIconSize: 500.sp,
                splashTransition: SplashTransition.fadeTransition,
                // pageTransitionType: PageTransitionsBuild,
                nextScreen: const OnBoardingScreen()),
            routes: {
              '/home': (context) =>  Homepage(),
              '/search_page': (context) =>  SearchPage(),
              '/user_login_or_reg': (context) =>  LoginOrRegister(),
              '/profile': (context) =>  ProfilePage(),
              '/my_bookings': (context) =>  MyBookingPage(),
              '/user_list': (context) =>  ListOfUsers(),
              '/admin_all_rooms': (context) =>  AllRooms(),
              '/admin_login': (context) =>  AdminLoginPage(),
              '/admin_home': (context) =>  AdminHomePage(),
            },
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            )
          );
        });
  }
}
