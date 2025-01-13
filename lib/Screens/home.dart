import 'package:Life_Connect/Providers/campaignProvider.dart';
import 'package:Life_Connect/Providers/donorProvider.dart';
import 'package:Life_Connect/Providers/profileProvider.dart';
import 'package:Life_Connect/widgets/customBanner.dart';
import 'package:Life_Connect/widgets/customCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<String> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('hospitalName') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    final donorProvider = Provider.of<DonorProvider>(context);
    final campProvider = Provider.of<CampaignProvider>(context);
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: FutureBuilder<String>(
            future: _getUsername(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.red,
                );
              }
              if (snapshot.hasError) {
                return Text(
                  'Guest',
                  style: TextStyle(fontSize: 19.sp, color: Colors.red),
                );
              }
              final hospitalName = snapshot.data ?? 'Guest';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospitalName,
                    style: GoogleFonts.archivo(
                      fontSize: 19.sp,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'welcome',
                    style: GoogleFonts.archivo(
                      fontSize: 18.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 9.h,
          actions: [
            Container(
              width: 7.h,
              height: 7.h,
              padding: const EdgeInsets.all(1),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.5),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child:
                    profileProvider.image == null || profileProvider.image == ''
                        ? Image.asset('assets/hospital.png')
                        : Image.network(
                            profileProvider.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(''),
                              );
                            },
                          ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 100.h,
            width: 100.w,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.5.w),
                  child: Row(
                    children: [
                      CustomCard(
                        title: 'Total\nDonors',
                        count: donorProvider.donors.length.toString(),
                        image: Image.asset(
                          'assets/donors.png',
                          height: 3.h,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      CustomCard(
                        title: 'Total\nHospitals',
                        count:
                            '34', // hospitaProvider.hospitals.length.toString(),
                        image: Image.asset(
                          'assets/hospital-1.png',
                          height: 4.h,
                        ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      CustomCard(
                        title: 'Total\nCamps',
                        count: campProvider.camp.length.toString(),
                        image: Image.asset(
                          'assets/camp.png',
                          height: 4.h,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.5.w,
                    bottom: 1.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Reminders',
                      style: TextStyle(
                          fontSize: 13.4.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CustomBanner(
                  title1: 'Surgery Sheduled',
                  title2:
                      'Organ surgery is shedule at 3:00 today Doctor: V Subramani Anasthesia Specialist: Neena Mathew',
                  buttonText: 'View',
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.5.w,
                    bottom: 1.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Alert',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CustomBanner(
                  title1: 'Alert John',
                  title2:
                      'Jhon has taken appoinment today with Dr Alexander Remind through chat!',
                  buttonText: 'Alert',
                  textColor: Colors.black,
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.h,
                    left: 3.5.w,
                    bottom: 1.h,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Graphical Analytics',
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                CustomBanner(
                    title1: 'Graphical Analystics',
                    title2: 'Graphical analystics of App Users',
                    textColor: Colors.white,
                    buttonText: 'View',
                    onPressed: () {},
                    imageUrl:
                        'https://www.cambridgemaths.org/Images/The-trouble-with-graphs.jpg'),
              ],
            ),
          ),
        ));
  }
}
