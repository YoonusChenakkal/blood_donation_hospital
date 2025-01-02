import 'package:blood_donation_hospital/Providers/donorProvider.dart';
import 'package:blood_donation_hospital/widgets/customBanner.dart';
import 'package:blood_donation_hospital/widgets/customCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final donorProvider = Provider.of<DonorProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marry Hospital',
                style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'welcome',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 8.h,
          actions: [
            Container(
              width: 5.3.h,
              height: 5.3.h,
              padding: const EdgeInsets.all(1.8),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://c1.wallpaperflare.com/preview/811/653/259/hospital-emergency-entrance-architecture-building-doctor.jpg',

                  fit: BoxFit
                      .cover, // Ensure the image fills the avatar appropriately
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Column(
            children: [
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomCard(
                    title: 'Total\nDonors',
                    number: donorProvider.donors.length.toString(),
                    icon: FontAwesomeIcons.hospital,
                  ),
                  CustomCard(
                    title: 'Donation\nRequests',
                    number: '34',
                    icon: FontAwesomeIcons.heart,
                  ),
                  CustomCard(
                    title: 'Appoinment\nSheduled',
                    number: '10',
                    icon: FontAwesomeIcons.warning,
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: .6.h,
                  left: 2.8.w,
                  bottom: .8.h,
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
                    'Organ surgery is shedule at 3:00 today\n\nDoctor: V Subramani\nAnasthesia Specialist: Neena Mathew',
                buttonText: 'View More',
                textColor: Colors.black,
                onPressed: () {},
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: .6.h,
                  left: 2.8.w,
                  bottom: 1.4.h,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alert',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomBanner(
                title1: 'Alert John',
                title2:
                    'Jhon has taken appoinment today with\nDr Alexander\n\nRemind through chat!',
                buttonText: 'Send Alert',
                textColor: Colors.black,
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 13.0,
                  left: 13,
                  bottom: 7,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Graphical Analytics',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomBanner(
                  title1: 'Graphical Analystics',
                  title2: '',
                  textColor: Colors.white,
                  buttonText: 'Show More',
                  onPressed: () {},
                  imageUrl:
                      'https://www.cambridgemaths.org/Images/The-trouble-with-graphs.jpg'),
            ],
          ),
        ));
  }
}
