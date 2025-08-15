import 'package:dance_up/features/events/components/dual_floating_button.dart';
import 'package:dance_up/features/events/screens/events_details.dart';
import 'package:flutter/material.dart';

class InstructorPhotosScreen extends StatelessWidget {
  const InstructorPhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos (21)",
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              child: ImageGrid(imageUrls: [
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
                'https://loremipsum.imgix.net/oPtkn7DsBOsv8aitV1qns/1606c26302d81bab448e3a39581f86b5/lorem-flickr-1280x720.jpg',
              ]),
            ),
          ),
          DualFloatingButtons(
            onGalleryTap: () {
              print('Gallery pressed');
            },
            onCameraTap: () {
              print('Camera pressed');
            },
          ),
        ],
      ),
    );
  }
}
