import 'dart:async';
import 'package:Life_Connect/Providers/authProvider.dart';
import 'package:Life_Connect/Providers/campaignProvider.dart';
import 'package:Life_Connect/Providers/chatsProvider.dart';
import 'package:Life_Connect/Providers/donorProvider.dart';
import 'package:Life_Connect/Providers/profileProvider.dart';
import 'package:Life_Connect/Providers/tabIndexNotifier.dart';
import 'package:Life_Connect/Screens/Bottom%20Naigation%20Bar/BottomNaigationBar.dart';
import 'package:Life_Connect/Screens/Splash%20Screen/splashScreen.dart';
import 'package:Life_Connect/Screens/campDetails.dart';
import 'package:Life_Connect/Screens/chat.dart';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
            ChangeNotifierProvider(create: (_) => ChatsProvider()),
            ChangeNotifierProvider(
                create: (_) => ProfileProvider()..fetchHospitalProfile()),
            ChangeNotifierProvider(
                create: (_) => CampaignProvider()..fetchCamps(context)),
            Provider(create: (_) => AuthService()),
            ChangeNotifierProvider(
                create: (_) => DonorProvider()..loadDonors()),
          ],
          child: const MainApp(), // Wrap the MainApp with Sizer
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
        '/chat': (context) => const ChatsPage(),
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
                  '/chat': (context) => const ChatsPage(),
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

// import 'package:Life_Connect/Providers/authProvider.dart';
// import 'package:Life_Connect/Providers/tabIndexNotifier.dart';
// import 'package:Life_Connect/Providers/userProfileProvider.dart';
// import 'package:Life_Connect/Screens/Bottom%20Naigation%20Bar/BottomNaigationBar.dart';
// import 'package:Life_Connect/Screens/certificateDetails.dart';
// import 'package:Life_Connect/Screens/certificatePage.dart';
// import 'package:Life_Connect/Screens/chat.dart';
// import 'package:Life_Connect/Screens/home.dart';
// import 'package:Life_Connect/Screens/login.dart';
// import 'package:Life_Connect/Screens/profile.dart';
// import 'package:Life_Connect/Screens/register.dart';
// import 'package:Life_Connect/Screens/userChat.dart';
// import 'package:Life_Connect/Screens/userProfile.dart';
// import 'package:Life_Connect/Screens/welcomePage.dart';
// import 'package:Life_Connect/Services/authService.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// void main() {
//   runApp(
//     Sizer(
//       builder: (context, orientation, deviceType) {
//         return MultiProvider(providers: [
//           ChangeNotifierProvider(create: (_) => AuthProvider()),
//           ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
//           ChangeNotifierProvider(create: (_) => UserProfileProvider()),
//           Provider(create: (_) => AuthService()),
//         ], child: const MainApp()); // Wrap the MainApp with Sizer
//       },
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/welcomePage',
//       routes: {
//         '/welcomePage': (context) => const WelcomePage(),
//         '/register': (context) => const Register(),
//         '/login': (context) => const Login(),
//         '/home': (context) => const HomePage(),
//         '/chats': (context) => const ChatsPage(),
//         '/userChat': (context) => const UserChat(),
//         '/profile': (context) => const ProfilePage(),
//         '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
//         '/certificateDetails': (context) => const CertificateDetails(),
//         '/userProfile': (context) => const UserProfile(),
//         '/certificatePage': (context) => const CertificatePage(),
//       },
//     );
//   }
// }
