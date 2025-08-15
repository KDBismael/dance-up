import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class InstructorNewsScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(
      title: "New Follower",
      message: "Jan Doe just followed you.",
      date: DateTime(2025, 6, 24),
      isSeen: false,
    ),
    NotificationModel(
      title: "New Event Attendee",
      message:
          "Someone just joined your event Dance Party IV. Check the details and get ready to dance!",
      date: DateTime(2025, 6, 21),
      isSeen: false,
      highlightWord: "Dance Party IV",
    ),
    NotificationModel(
      title: "New Follower",
      message: "Jan Doe just followed you.",
      date: DateTime(2025, 6, 24),
      isSeen: false,
    ),
    NotificationModel(
      title: "New Follower",
      message: "Jan Doe just followed you.",
      date: DateTime(2025, 6, 24),
      isSeen: true,
    ),
    NotificationModel(
      title: "New Event Attendee",
      message:
          "Someone just joined your event Dance Party IV. Check the details and get ready to dance!",
      date: DateTime(2025, 6, 21),
      isSeen: true,
      highlightWord: "Dance Party IV",
    ),
  ];

  InstructorNewsScreen({super.key});
// Make all unseen notificatyions seen as read when the page is closed
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What’s New",
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          return NotificationItem(notification: notifications[index]);
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  const NotificationItem({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr =
        "${notification.date.day.toString().padLeft(2, '0')} ${_month(notification.date.month)} ${notification.date.year}";

    final messageSpans = <TextSpan>[];
    if (notification.highlightWord != null &&
        notification.message.contains(notification.highlightWord!)) {
      final parts = notification.message.split(notification.highlightWord!);
      messageSpans.add(TextSpan(text: parts[0]));
      messageSpans.add(TextSpan(
        text: notification.highlightWord!,
        style: const TextStyle(
            color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ));
      messageSpans.add(TextSpan(text: parts[1]));
    } else {
      messageSpans.add(TextSpan(text: notification.message));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(Icons.circle,
                size: 10,
                color: notification.isSeen
                    ? Colors.transparent
                    : AppColors.accent),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style:
                            Theme.of(context).textTheme?.labelSmall?.copyWith(
                                  fontWeight: notification.isSeen
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                  color: notification.isSeen
                                      ? AppColors.blackGray
                                      : theme.textTheme.bodyLarge!.color,
                                ),
                      ),
                    ),
                    Text(
                      dateStr,
                      style: TextStyle(
                        color: AppColors.blackGray,
                        fontSize: 13,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: notification.isSeen
                          ? AppColors.blackGray
                          : AppColors.black,
                      fontSize: 14,
                    ),
                    children: messageSpans,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _month(int m) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[m - 1];
  }
}

class NotificationModel {
  final String title;
  final String message;
  final DateTime date;
  final bool isSeen;
  final String? highlightWord;

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    this.isSeen = false,
    this.highlightWord,
  });
}
