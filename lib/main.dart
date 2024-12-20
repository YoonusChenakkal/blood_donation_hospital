import 'dart:async';
import 'package:blood_donation_hospital/Providers/authProvider.dart';
import 'package:blood_donation_hospital/Providers/campaignProvider.dart';
import 'package:blood_donation_hospital/Providers/donorProvider.dart';
import 'package:blood_donation_hospital/Providers/tabIndexNotifier.dart';
import 'package:blood_donation_hospital/Providers/userProfileProvider.dart';
import 'package:blood_donation_hospital/Screens/Bottom%20Naigation%20Bar/BottomNaigationBar.dart';
import 'package:blood_donation_hospital/Screens/certificateDetails.dart';
import 'package:blood_donation_hospital/Screens/donorList.dart';
import 'package:blood_donation_hospital/Screens/shedule.dart';
import 'package:blood_donation_hospital/Screens/home.dart';
import 'package:blood_donation_hospital/Screens/login.dart';
import 'package:blood_donation_hospital/Screens/profile.dart';
import 'package:blood_donation_hospital/Screens/register.dart';
import 'package:blood_donation_hospital/Screens/userChat.dart';
import 'package:blood_donation_hospital/Screens/userProfile.dart';
import 'package:blood_donation_hospital/Screens/welcomePage.dart';
import 'package:blood_donation_hospital/Services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => TabIndexNotifier()),
            ChangeNotifierProvider(create: (_) => UserProfileProvider()),
            ChangeNotifierProvider(create: (_) => CampaignProvider()),
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

  // Function to check whether uniqueId is present in SharedPreferences
  Future<String> checkInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    String? uniqueId = prefs.getString('uniqueId');
    // If uniqueId exists, return '/home' (i.e., Bottom Navigation Bar), otherwise '/welcomePage'
    return uniqueId != null && uniqueId.isNotEmpty
        ? '/bottomNavigationBar'
        : '/welcomePage';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Use FutureBuilder to check if uniqueId exists
      initialRoute: '/',
      routes: {
        '/welcomePage': (context) => const WelcomePage(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
        '/shedule': (context) => const ShedulePage(),
        '/userChat': (context) => const UserChat(),
        '/profile': (context) => const ProfilePage(),
        '/bottomNavigationBar': (context) => const CustomBottomNavigationBar(),
        '/certificateDetails': (context) => const CertificateDetails(),
        '/userProfile': (context) => const UserProfile(),
        '/donorList': (context) => DonorListPage(),
      },
      // Use FutureBuilder to asynchronously set initial route based on uniqueId presence
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
                  '/welcomePage': (context) => const WelcomePage(),
                  '/register': (context) => const Register(),
                  '/login': (context) => const Login(),
                  '/home': (context) => const HomePage(),
                  '/shedule': (context) => const ShedulePage(),
                  '/userChat': (context) => const UserChat(),
                  '/profile': (context) => const ProfilePage(),
                  '/bottomNavigationBar': (context) =>
                      const CustomBottomNavigationBar(),
                  '/certificateDetails': (context) =>
                      const CertificateDetails(),
                  '/userProfile': (context) => const UserProfile(),
                  '/donorList': (context) => DonorListPage()
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

// import 'package:blood_donation_hospital/Providers/authProvider.dart';
// import 'package:blood_donation_hospital/Providers/tabIndexNotifier.dart';
// import 'package:blood_donation_hospital/Providers/userProfileProvider.dart';
// import 'package:blood_donation_hospital/Screens/Bottom%20Naigation%20Bar/BottomNaigationBar.dart';
// import 'package:blood_donation_hospital/Screens/certificateDetails.dart';
// import 'package:blood_donation_hospital/Screens/certificatePage.dart';
// import 'package:blood_donation_hospital/Screens/chat.dart';
// import 'package:blood_donation_hospital/Screens/home.dart';
// import 'package:blood_donation_hospital/Screens/login.dart';
// import 'package:blood_donation_hospital/Screens/profile.dart';
// import 'package:blood_donation_hospital/Screens/register.dart';
// import 'package:blood_donation_hospital/Screens/userChat.dart';
// import 'package:blood_donation_hospital/Screens/userProfile.dart';
// import 'package:blood_donation_hospital/Screens/welcomePage.dart';
// import 'package:blood_donation_hospital/Services/authService.dart';
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
