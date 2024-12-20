import 'dart:convert';
import 'package:blood_donation_hospital/Providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CampaignProvider with ChangeNotifier {
  String? hospitalName;
  String? location;
  String? description;
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void setHospitalName(String value) {
    hospitalName = value;
    notifyListeners();
  }

  void setLocation(String value) {
    location = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    selectedDate = value;
    notifyListeners();
  }

  void setStartTime(TimeOfDay value) {
    startTime = value;
    notifyListeners();
  }

  void setEndTime(TimeOfDay value) {
    endTime = value;
    notifyListeners();
  }

  bool isFormValid() {
    return hospitalName != null &&
        hospitalName!.isNotEmpty &&
        location != null &&
        location!.isNotEmpty &&
        description != null &&
        description!.isNotEmpty &&
        selectedDate != null &&
        startTime != null &&
        endTime != null;
  }

  void clearForm() {
    hospitalName = null;
    location = null;
    description = null;
    selectedDate = null;
    startTime = null;
    endTime = null;
    notifyListeners();
  }

  Future<void> registerCampaign(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final url = Uri.parse(
        'https://lifeproject.pythonanywhere.com/hospital/hospital/blood-donation-camps/');

    authProvider.isLoading = true; // Start loading state
    try {
      // Format date as "yyyy-MM-dd"
      final formattedDate = selectedDate != null
          ? '${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}'
          : '';

      // Format time as "HH:mm:ss.SSSSSS"
      String formatTimeOfDay(TimeOfDay? time) {
        if (time == null) return '';
        final now = DateTime.now();
        final dateTime =
            DateTime(now.year, now.month, now.day, time.hour, time.minute);
        return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:00.000000';
      }

      final formattedStartTime = formatTimeOfDay(startTime);
      final formattedEndTime = formatTimeOfDay(endTime);

      if (hospitalName == null ||
          location == null ||
          description == null ||
          formattedDate.isEmpty ||
          formattedStartTime.isEmpty ||
          formattedEndTime.isEmpty) {
        throw Exception("One or more required fields are null");
      }

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'hospital': hospitalName ?? '',
          'date': formattedDate,
          'location': location ?? '',
          'start_time': formattedStartTime,
          'end_time': formattedEndTime,
          'description': description ?? '',
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'] ?? 'Campaign registered successfully!'),
          duration: const Duration(seconds: 2),
        ));
        clearForm();

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/bottomNavigationBar',
          (route) => false,
        );
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        String errorMessage = data['detail'] ??
            (data['date'] is List ? data['date'].join(', ') : 'Invalid data');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 2),
        ));
      } else {
        throw Exception(
            'Unexpected error occurred. Status: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: const Duration(seconds: 2),
      ));
    } finally {
      authProvider.isLoading = false;
    }
  }
}
