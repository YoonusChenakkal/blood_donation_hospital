import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

enum InfoCardType { donor, camp }

class InfoCard extends StatelessWidget {
  final String title;
  final String address;
  final String contactNumber;
  final String date;
  final String badgeText;
  final InfoCardType type;

  const InfoCard({
    Key? key,
    required this.title,
    required this.address,
    required this.contactNumber,
    required this.date,
    required this.badgeText,
    required this.type,
  }) : super(key: key);

  Color get badgeColor {
    switch (type) {
      case InfoCardType.donor:
        return Colors.red;
      case InfoCardType.camp:
        return Colors.white;
    }
  }

  Color get cardColor {
    switch (type) {
      case InfoCardType.donor:
        return Colors.white;
      case InfoCardType.camp:
        return Colors.red;
    }
  }

  Color get textColor {
    switch (type) {
      case InfoCardType.donor:
        return Colors.black;
      case InfoCardType.camp:
        return Colors.white;
    }
  }

  Color get borderColor {
    switch (type) {
      case InfoCardType.donor:
        return Colors.red;
      case InfoCardType.camp:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        border: Border.all(color: borderColor, width: 1.4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Color.fromARGB(90, 0, 0, 0),
            offset: Offset(2, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: badgeColor,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  badgeText,
                  style: TextStyle(
                      color: type == InfoCardType.donor
                          ? Colors.white
                          : Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp),
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
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: .7.h),
                Text(
                  address,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: .5.h),
                Text(
                  '+91 $contactNumber',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: .5.h),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
