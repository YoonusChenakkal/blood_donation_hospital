import 'package:blood_donation_hospital/Providers/campaignProvider.dart';
import 'package:blood_donation_hospital/widgets/customButton.dart';
import 'package:blood_donation_hospital/widgets/infoCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class userRegisteredListSection extends StatelessWidget {
  const userRegisteredListSection({super.key, required this.filteredCamp});
  final filteredCamp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<CampaignProvider>(
        builder: (context, campsProvider, child) {
          if (campsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (campsProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    campsProvider.errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomButton(
                      text: 'Retry',
                      buttonType: ButtonType.Outlined,
                      isLoading: campsProvider.isLoading,
                      onPressed: () => campsProvider.fetchRegistrations(
                          filteredCamp.id, context))
                ],
              ),
            );
          }

          if (campsProvider.campRegistrations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Camps Available",
                    style: TextStyle(fontSize: 17.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomButton(
                      text: 'Refresh',
                      buttonType: ButtonType.Outlined,
                      isLoading: campsProvider.isLoading,
                      onPressed: () => campsProvider.fetchRegistrations(
                          filteredCamp.id, context))
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await campsProvider.fetchRegistrations(filteredCamp.id, context);
            },
            child: ListView.builder(
              itemCount: campsProvider.campRegistrations.isNotEmpty
                  ? campsProvider.campRegistrations[0].registrations.length
                  : 0,
              itemBuilder: (context, index) {
                final registeredUserList =
                    campsProvider.campRegistrations[0].registrations[index];
                return InfoCard(
                  title: registeredUserList.username,
                  address: registeredUserList.address,
                  contactNumber: registeredUserList.contactNumber.toString(),
                  date: DateFormat('dd-MM-yyyy')
                      .format(registeredUserList.registrationDate),
                  badgeText: registeredUserList.bloodGroup,
                  type: InfoCardType.camp,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
