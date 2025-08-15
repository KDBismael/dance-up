import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InstructorAttendeesScreen extends StatelessWidget {
  InstructorAttendeesScreen({super.key});
  var selectedSortBy = AttendeesSortBy.all.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendees (10)",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Attendees(
            attendeesId: List.generate(10, (index) => (index + 1).toString()),
            haveAttendees: true,
            selectedSortBy: selectedSortBy,
          ),
        ),
      ),
    );
  }
}
