import 'package:Life_Connect/Providers/userProfileProvider.dart';
import 'package:Life_Connect/widgets/customButton.dart';
import 'package:Life_Connect/widgets/customCheckbox.dart';
import 'package:Life_Connect/widgets/customDropdown.dart';
import 'package:Life_Connect/widgets/customIdProof.dart';
import 'package:Life_Connect/widgets/customMultiSelect.dart';
import 'package:Life_Connect/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UserProfileEdit extends StatelessWidget {
  const UserProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'assets/bg_threenurse.jpg',
            ),
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
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 23.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    CustomTextfield(
                      enabled: false,
                      hintText: userProfileProvider.name ?? 'name',
                      keyboardType: TextInputType.name,
                      icon: Icons.person_2_outlined,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomTextfield(
                      hintText: userProfileProvider.address ?? 'Address',
                      keyboardType: TextInputType.streetAddress,
                      icon: Icons.place_outlined,
                      onChanged: (value) {
                        userProfileProvider.editedAddress = value.trim();
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomTextfield(
                      hintText: userProfileProvider.phone ?? 'Phone',
                      keyboardType: TextInputType.number,
                      icon: Icons.phone_in_talk_outlined,
                      onChanged: (value) {
                        userProfileProvider.editedPhone = value.trim();
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    Customdropdown(
                      hintText: userProfileProvider.bloodGroup ?? 'BloodGroup',
                      selectedValue: userProfileProvider.editedBloodGroup,
                      onChanged: (value) {
                        userProfileProvider.editedBloodGroup = value;
                      },
                    ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    const CustomIdProof(),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomCheckbox(
                        title: 'Willing Donate to Organs',
                        textColor: Colors.white,
                        isChecked: userProfileProvider.isOrganChecked,
                        onChanged: (value) {
                          userProfileProvider.isOrganChecked = value!;
                        }),
                    if (userProfileProvider.isOrganChecked)
                      CustomMultiSelectDropdown(
                        title: 'Select Organs to Donate',
                        options: ['Heart', 'Liver', 'Kidney', 'Lungs', 'Eyes'],
                        selectedItems: userProfileProvider.editedOrgansToDonate,
                        onChanged: (selected) {
                          userProfileProvider
                              .updateEditedOrgansToDonate(selected);
                        },
                      ),
                    SizedBox(
                      height: 1.3.h,
                    ),
                    CustomCheckbox(
                        title: 'Willing Donate to Blood ',
                        textColor: Colors.white,
                        isChecked: userProfileProvider.isBloodChecked,
                        onChanged: (value) {
                          userProfileProvider.isBloodChecked = value!;
                          print(userProfileProvider.isBloodChecked);
                        }),

                    SizedBox(
                      height: 1.3.h,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    // Submit Button
                    CustomButton(
                      text: 'Submit',
                      isLoading: userProfileProvider.isLoading,
                      textColor: const Color.fromARGB(255, 230, 3, 3),
                      onPressed: () {
                        if (userProfileProvider.profileData['id'] == null ||
                            userProfileProvider.profileData['id'] == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile Not Found')),
                          );
                        } else if ((userProfileProvider.isOrganChecked &&
                            (userProfileProvider.editedOrgansToDonate as List)
                                .isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Select organs')),
                          );
                        } else {
                          // Proceed with Register User Profile
                          userProfileProvider.updateUserProfile(
                              context,
                              userProfileProvider.profileData['id'],
                              userProfileProvider.editedAddress,
                              userProfileProvider.editedPhone,
                              userProfileProvider.idProofImage,
                              userProfileProvider.editedBloodGroup,
                              userProfileProvider.editedOrgansToDonate,
                              userProfileProvider.isBloodChecked,
                              userProfileProvider.isOrganChecked);
                        }
                      },
                      buttonType: ButtonType.Outlined,
                    ),

                    SizedBox(
                      height: 2.h,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
