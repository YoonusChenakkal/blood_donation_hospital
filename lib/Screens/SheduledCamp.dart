import 'package:blood_donation_hospital/Providers/campaignProvider.dart';
import 'package:blood_donation_hospital/widgets/campCard.dart';
import 'package:blood_donation_hospital/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SheduledCamp extends StatelessWidget {
  const SheduledCamp({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Camp',
          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        //  shape: CircleBorder(),
        backgroundColor: Colors.red,
        onPressed: () => Navigator.pushNamed(context, '/sheduledCamp'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<CampaignProvider>(
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
                      onPressed: () => campsProvider.fetchCamps(context))
                ],
              ),
            );
          }

          if (campsProvider.filteredCamps.isEmpty) {
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
                      onPressed: () => campsProvider.fetchCamps(context))
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await campsProvider.fetchCamps(context);
            },
            child: ListView.builder(
              itemCount: campsProvider.filteredCamps.length,
              itemBuilder: (context, index) {
                final filteredCamp = campsProvider.filteredCamps[index];
                return Campcard(filteredCamp: filteredCamp);
              },
            ),
          );
        },
      ),
    );
  }
}
