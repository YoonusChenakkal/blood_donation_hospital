import 'package:blood_donation_hospital/Models/campsModel.dart';
import 'package:blood_donation_hospital/Providers/campaignProvider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class Campcard extends StatelessWidget {
  const Campcard({
    super.key,
    required this.filteredCamp,
  });
  final CampsModel filteredCamp;

  String formatDate(DateTime? date) {
    if (date == null) return 'Unknown Date';
    return DateFormat('MMMM d, yyyy').format(date); // Example: January 9, 2025
  }

  String formatTime(String? time) {
    if (time == null) return 'Unknown Time';
    try {
      final parsedTime = DateFormat("HH:mm:ss").parse(time);
      return DateFormat("h:mm a").format(parsedTime); // Example: 10:00 AM
    } catch (e) {
      return 'Invalid Time';
    }
  }

  String formatCreatedAt(DateTime? date) {
    return date != null
        ? DateFormat('MMMM d, yyyy').format(date)
        : 'Unknown Date';
  }

  @override
  Widget build(BuildContext context) {
  

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        '/campDetails',
        arguments: filteredCamp, // Passing the camp object
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 1.4),
          boxShadow: const [
            BoxShadow(
                blurRadius: 8,
                color: Color.fromARGB(90, 0, 0, 0),
                offset: Offset(2, 1))
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 1.h,
              right: 2.w,
              child: Text(
                formatCreatedAt(filteredCamp.createdAt),
                style: TextStyle(fontSize: 13.sp, color: Colors.black),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    filteredCamp.hospital ?? 'No Hospital Name',
                    style: TextStyle(fontSize: 15.3.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${formatDate(filteredCamp.date)}',
                    style:
                        TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: .7.h),
                  Text(
                    'Time: ${formatTime(filteredCamp.startTime)} - ${formatTime(filteredCamp.endTime)}',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: .5.h),
                  Text(
                    'Location: ${filteredCamp.location ?? 'Unknown Location'}',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: .5.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
