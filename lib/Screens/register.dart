import 'package:Life_Connect/Providers/authProvider.dart';
import 'package:Life_Connect/Services/authService.dart';
import 'package:Life_Connect/widgets/customButton.dart';
import 'package:Life_Connect/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        authProvider.name = null;
        authProvider.email = null;
        authProvider.otp = null;
        authProvider.address = null;
        authProvider.phone = null;
        authProvider.showOtpField = false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/bg_child.png'),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 4.h,
                child: IconButton(
                  onPressed: () {
                    authProvider.reset();
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: const Color.fromARGB(255, 209, 209, 209),
                    size: 24.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 23.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    CustomTextfield(
                      hintText: 'Hospital Name',
                      keyboardType: TextInputType.name,
                      icon: FontAwesomeIcons.hospital,
                      onChanged: (value) {
                        authProvider.name = value.trim();
                      },
                      enabled: authProvider.showOtpField ? false : true,
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomTextfield(
                      hintText: 'Enter Your Email',
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.email_outlined,
                      enabled: authProvider.showOtpField ? false : true,
                      onChanged: (value) {
                        authProvider.email = value.trim();
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomTextfield(
                      hintText: 'Phone',
                      keyboardType: TextInputType.number,
                      icon: Icons.phone_in_talk_outlined,
                      enabled: authProvider.showOtpField ? false : true,
                      onChanged: (value) {
                        authProvider.phone = value.trim();
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomTextfield(
                      hintText: 'Place',
                      keyboardType: TextInputType.streetAddress,
                      icon: Icons.place_outlined,
                      enabled: authProvider.showOtpField ? false : true,
                      onChanged: (value) {
                        authProvider.address = value.trim();
                      },
                    ),

                    // Show OTP field only if the response code was 201
                    if (authProvider.showOtpField) ...[
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomTextfield(
                        hintText: 'Enter OTP',
                        keyboardType: TextInputType.number,
                        icon: Icons.lock,
                        onChanged: (data) {
                          authProvider.otp = data.trim();
                        },
                      ),
                    ],
                    SizedBox(
                      height: 4.5.h,
                    ),
                    // Submit Button
                    CustomButton(
                      text: authProvider.showOtpField ? 'Register' : 'Submit',
                      isLoading:authProvider.isLoading ,
                      onPressed: authProvider.showOtpField
                          ? () {
                              if (authProvider.otp!.isEmpty ||
                                  authProvider.otp == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please Enter OTP')),
                                );
                              } else {
                                authService.verifyRegisterOtp(
                                    authProvider.email!,
                                    authProvider.otp!,
                                    context,
                                    authProvider);
                              }
                            }
                          : () {
                              // Check if all required fields are filled
                              if (authProvider.name == null ||
                                  authProvider.name!.isEmpty ||
                                  authProvider.email == null ||
                                  authProvider.email!.isEmpty ||
                                  authProvider.address == null ||
                                  authProvider.address!.isEmpty ||
                                  authProvider.phone == null ||
                                  authProvider.phone!.isEmpty) {
                                // Show error message if any field is empty
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields.')),
                                );
                              } else {
                                // Proceed with registration
                                authService.registerUser(
                                    authProvider.name!,
                                    authProvider.email!,
                                    authProvider.phone!,
                                    authProvider.address!,
                                    context,
                                    authProvider);
                              }
                            },
                      buttonType: ButtonType.Outlined,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
