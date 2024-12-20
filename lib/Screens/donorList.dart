import 'package:blood_donation_hospital/Providers/donorProvider.dart';
import 'package:blood_donation_hospital/widgets/donorCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class DonorListPage extends StatelessWidget {
  const DonorListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> bloodGroups = [
      'All',
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-'
    ];

    String selectedBloodGroup = 'All';

    void _filterByBloodGroup(BuildContext context, String group) {
      Provider.of<DonorProvider>(context, listen: false).filterByBloodGroup(group);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donor List',
          style: TextStyle(fontSize: 23.sp, fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
                width: 75.w,
                child: SearchBar(
                  onChanged: (query) =>
                      Provider.of<DonorProvider>(context, listen: false)
                          .searchDonors(query),
                  backgroundColor: WidgetStatePropertyAll(Colors.red[50]),
                  leading: Icon(Icons.search),
                  hintText: 'Search',
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.filter_list, size: 24.sp),
                  onSelected: (value) {
                    selectedBloodGroup = value;
                    _filterByBloodGroup(context, value);
                  },
                  itemBuilder: (context) {
                    return bloodGroups.map((group) {
                      return PopupMenuItem<String>(
                        value: group,
                        child: Text(
                          group,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer<DonorProvider>(
              builder: (context, donorProvider, _) {
                if (donorProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (donorProvider.errorMessage != null) {
                  return Center(
                    child: Text(
                      donorProvider.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (donorProvider.donors.isEmpty) {
                  return Center(
                    child: Text(
                      'No Donors Available',
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  );
                }

                if (donorProvider.filteredDonors.isEmpty) {
                  return Center(
                    child: Text(
                      "No donors match your search or filter.",
                      style: TextStyle(fontSize: 17.sp),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<DonorProvider>(context, listen: false)
                        .loadDonors();
                  },
                  child: ListView.builder(
                    itemCount: donorProvider.filteredDonors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 5.w),
                        child: DonorCard(
                          donor: donorProvider.filteredDonors[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
