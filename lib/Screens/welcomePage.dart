import 'package:Life_Connect/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_nurse.jpg'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                child: SizedBox(
                  height: 55.h,
                  width: 100.w,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'When we ',
                              style: TextStyle(
                                  fontSize: 25.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              'donate',
                              style: TextStyle(
                                  fontSize: 25.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromARGB(255, 255, 17, 0)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'we connect ',
                              style: TextStyle(
                                fontSize: 24.5.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'lives',
                              style: TextStyle(
                                  fontSize: 24.5.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            )
                          ],
                        ),
                        Text(
                          '"Be the reason someone smiles today"',
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Center(
                            child: CustomButton(
                                text: 'Login',
                                buttonType: ButtonType.Outlined,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                })),
                        SizedBox(
                          height: 2.h,
                        ),
                        Center(
                            child: CustomButton(
                                text: 'Register',
                                buttonType: ButtonType.Elevated,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/register');
                                })),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
