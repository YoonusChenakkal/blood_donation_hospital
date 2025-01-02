import 'package:blood_donation_hospital/Models/campsModel.dart';
import 'package:blood_donation_hospital/Providers/authProvider.dart';
import 'package:blood_donation_hospital/Providers/campaignProvider.dart';
import 'package:blood_donation_hospital/Sections/campDetailsSection.dart';
import 'package:blood_donation_hospital/widgets/customButton.dart';
import 'package:blood_donation_hospital/Sections/registeredUserListSection.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CampDetails extends StatelessWidget {
  const CampDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final campProvider = Provider.of<CampaignProvider>(context);

    final CampsModel filteredCamp =
        ModalRoute.of(context)!.settings.arguments as CampsModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Camp Details',
          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CampDetailsSection(
            filteredCamp: filteredCamp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  text: 'Edit',
                  buttonType: ButtonType.Outlined,
                  onPressed: () => Navigator.pushNamed(
                      context, '/editCampDetails',
                      arguments: filteredCamp)),
              SizedBox(
                width: 2.w,
              ),
              CustomButton(
                  text: 'Delete',
                  buttonType: ButtonType.Elevated,
                  isLoading: campProvider.isLoading,
                  onPressed: () => campProvider.deleteCamp(
                      filteredCamp.id, context)),
            ],
          ),
          const Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(10), child: Text('Registered Users')),
            ],
          ),
          userRegisteredListSection(
            filteredCamp: filteredCamp,
          ),
        ],
      ),
    );
  }
}
