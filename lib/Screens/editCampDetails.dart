import 'package:blood_donation_hospital/Models/campsModel.dart';
import 'package:blood_donation_hospital/Providers/authProvider.dart';
import 'package:blood_donation_hospital/Providers/campaignProvider.dart';
import 'package:blood_donation_hospital/widgets/customButton.dart';
import 'package:blood_donation_hospital/widgets/customTextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditCampDetails extends StatelessWidget {
  const EditCampDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final campaignProvider = Provider.of<CampaignProvider>(context);
  final CampsModel filteredCamp =
        ModalRoute.of(context)!.settings.arguments as CampsModel;
   
   
   
   _pickDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        campaignProvider.setDate(picked);
      }
    }

     _pickTime(BuildContext context,
        {required bool isStartTime}) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (picked != null) {
        if (isStartTime) {
          campaignProvider.setStartTime(picked);
        } else {
          campaignProvider.setEndTime(picked);
        }
      }
    }

    String _formatDate(DateTime? date) {
      if (date == null) return 'Select Date';
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    String _formatTime(TimeOfDay? time, {required bool isStartTime}) {
      if (time == null) return isStartTime ? 'Start Time' : 'End Time';
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }

    return WillPopScope(
      onWillPop: () async {
        campaignProvider.clearForm();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: 100.h,
          width: 100.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://c1.wallpaperflare.com/preview/910/704/36/guardian-angel-doctor-health-angel.jpg',
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
                    campaignProvider.clearForm();
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
                        'Edit Campaign Details',
                        style: TextStyle(
                          fontSize: 23.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    CustomTextfield(
                        hintText: 'Location',
                        icon: Icons.place_outlined,
                        onChanged: (value) =>
                            campaignProvider.setLocation(value),
                        keyboardType: TextInputType.streetAddress),
                    SizedBox(height: 2.h),
                    InkWell(
                      onTap: () => _pickDate(context),
                      child: CustomTextfield(
                          enabled: false,
                          hintText: _formatDate(campaignProvider.selectedDate),
                          icon: Icons.date_range_outlined,
                          onChanged: (value) {},
                          keyboardType: TextInputType.none),
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => _pickTime(context, isStartTime: true),
                          child: CustomTextfield(
                            width: 35,
                            enabled: false,
                            hintText: _formatTime(campaignProvider.startTime,
                                isStartTime: true),
                            icon: Icons.access_time_rounded,
                            onChanged: (value) {},
                            keyboardType: TextInputType.none,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        InkWell(
                          onTap: () => _pickTime(context, isStartTime: false),
                          child: CustomTextfield(
                            width: 35,
                            enabled: false,
                            hintText: _formatTime(campaignProvider.endTime,
                                isStartTime: false),
                            icon: Icons.access_time_outlined,
                            onChanged: (value) {},
                            keyboardType: TextInputType.none,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    CustomTextfield(
                        height: 7.5,
                        hintText: 'Description',
                        icon: Icons.notes,
                        onChanged: (value) =>
                            campaignProvider.setDescription(value),
                        keyboardType: TextInputType.multiline),
                    SizedBox(height: 4.5.h),
                    CustomButton(
                      text: 'Submit',isLoading: campaignProvider.isLoading,
                      onPressed: () {
                       
                        if (!campaignProvider.isFormValid()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill out all fields'),
                            ),
                          );
                        } else {
                          campaignProvider.editCamp(
                              filteredCamp.id, context);
                        }
                      },
                      buttonType: ButtonType.Outlined,
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
