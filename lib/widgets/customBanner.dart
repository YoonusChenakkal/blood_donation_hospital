import 'package:blood_donation_hospital/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBanner extends StatelessWidget {
  CustomBanner({
    super.key,
    this.height = 16,
    this.width = 92,
    this.buttonText = '',
    this.imageUrl = '',
    this.button = true,
    this.bannerColor = const Color.fromARGB(255, 243, 243, 243),
    required this.title1,
    required this.title2,
    required this.textColor,
    required this.onPressed,
  });
  double height;
  double width;
  String imageUrl;
  String title1;
  String title2;
  String buttonText;
  Color bannerColor;
  Color textColor;
  bool button;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: bannerColor,
        borderRadius: BorderRadius.circular(8),
        image: imageUrl.isEmpty
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.9,
                image: NetworkImage(imageUrl),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: imageUrl.isEmpty ? 13.6.sp : 15.sp,
                          color: imageUrl.isEmpty ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(
                    title2,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: imageUrl.isEmpty ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            if (button) ...[
              SizedBox(
                height: 1.h,
              ),
              CustomButton(
                  height: 3,
                  width: 21.1,
                  text: buttonText,
                  buttonType: ButtonType.Ovelshaped,
                  onPressed: onPressed)
            ]
          ],
        ),
      ),
    );
  }
}
