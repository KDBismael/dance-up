import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:flutter/material.dart';

class InstructorReviewsScreen extends StatelessWidget {
  const InstructorReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reviews (2)",
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
          child: Reviews(
            haveReviews: true,
            reviewsId: ["1", "2"],
          ),
        ),
      ),
    );
  }
}
