import 'dart:async';
import 'package:Life_Connect/Providers/authProvider.dart';
import 'package:Life_Connect/Providers/campaignProvider.dart';
import 'package:Life_Connect/Providers/chatsProvider.dart';
import 'package:Life_Connect/Providers/donorProvider.dart';
import 'package:Life_Connect/Providers/hosptalcountProvider.dart';
import 'package:Life_Connect/Providers/profileProvider.dart';
import 'package:Life_Connect/Providers/tabIndexNotifier.dart';
import 'package:Life_Connect/Screens/Bottom%20Naigation%20Bar/BottomNaigationBar.dart';
import 'package:Life_Connect/Screens/Splash%20Screen/splashScreen.dart';
import 'package:Life_Connect/Screens/campDetails.dart';
import 'package:Life_Connect/Screens/donorChat.dart';
import 'package:Life_Connect/Screens/donorDetails.dart';
import 'package:Life_Connect/Screens/donorList.dart';
import 'package:Life_Connect/Screens/editCampDetails.dart';
import 'package:Life_Connect/Screens/editProfileDetails.dart';
import 'package:Life_Connect/Screens/registerCampaign.dart';
import 'package:Life_Connect/Screens/shedule.dart';
import 'package:Life_Connect/Screens/home.dart';
import 'package:Life_Connect/Screens/login.dart';
import 'package:Life_Connect/Screens/profile.dart';
import 'package:Life_Connect/Screens/register.dart';
import 'package:Life_Connect/Screens/welcomePage.dart';
import 'package:Life_Connect/Services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  // Ensure widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Run the app
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
            ChangeNotifierProvider(create: (_) => ChatsProvider()),
            ChangeNotifierProvider(
                create: (_) => HospitalCountProvider()..loadHospitalCount()),
            ChangeNotifierProvider(
                create: (_) => ProfileProvider()..fetchHospitalProfile()),
            ChangeNotifierProvider(
                create: (_) => CampaignProvider()..fetchCamps(context)),
            Provider(create: (_) => AuthService()),
            ChangeNotifierProvider(
                create: (_) => DonorProvider()..loadDonors()),
          ],
          child: const MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // Function to check whether hospitalName is present in SharedPreferences
  Future<String> checkInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    String? hospitalName = prefs.getString('hospitalName');
    // If hospitalName exists, return '/home' (i.e., Bottom Navigation Bar), otherwise '/welcomePage'
    return hospitalName != null && hospitalName.isNotEmpty
        ? '/splashScreen'
        : '/welcomePage';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Use FutureBuilder to check if hospitalName exists
      navigatorKey: navigatorKey,

      initialRoute: '/',
      routes: {
        '/splashScreen': (context) => SplashScreen(),
        '/welcomePage': (context) => const WelcomePage(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/shedule': (context) => const ShedulePage(),
        '/donorChat': (context) => const DonorChat(),
        '/profile': (context) => const ProfilePage(),
        '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
        '/donorList': (context) => const DonorListPage(),
        '/sheduledCamp': (context) => const RegisterCampaign(),
        '/campDetails': (context) => const CampDetails(),
        '/editCampDetails': (context) => const EditCampDetails(),
        '/editProfileDetails': (context) => const EditProfileDetails(),
        '/donorDetails': (context) => const Donordetails(),
      },
      // Use FutureBuilder to asynchronously set initial route based on hospitalName presence
      builder: (context, child) {
        return FutureBuilder<String>(
          future: checkInitialRoute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return MaterialApp(
                initialRoute: snapshot.data,
                routes: {
                  '/splashScreen': (context) => SplashScreen(),
                  '/welcomePage': (context) => const WelcomePage(),
                  '/register': (context) => const Register(),
                  '/login': (context) => const Login(),
                  '/home': (context) => const HomePage(),
                  '/shedule': (context) => const ShedulePage(),
                  '/donorChat': (context) => const DonorChat(),
                  '/profile': (context) => const ProfilePage(),
                  '/bottomNavigationBar': (context) =>
                      const CustomBottomNavigationBar(),
                  '/donorList': (context) => const DonorListPage(),
                  '/sheduledCamp': (context) => const RegisterCampaign(),
                  '/campDetails': (context) => const CampDetails(),
                  '/editCampDetails': (context) => const EditCampDetails(),
                  '/editProfileDetails': (context) =>
                      const EditProfileDetails(),
                  '/donorDetails': (context) => const Donordetails(),
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }
}
