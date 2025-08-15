import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventSummary {
  final String title;
  final String location;
  final bool isFree;
  final int attendees;
  final String imageUrl;

  EventSummary({
    required this.title,
    required this.location,
    required this.isFree,
    required this.attendees,
    required this.imageUrl,
  });
}

class ManageEventsScreen extends StatefulWidget {
  const ManageEventsScreen({super.key});

  @override
  State<ManageEventsScreen> createState() => _ManageEventsScreenState();
}

class _ManageEventsScreenState extends State<ManageEventsScreen> {
  bool isUpcoming = true;

  final List<EventSummary> events = [
    EventSummary(
      title: "Dance Party III",
      location: "East Java (15 m)",
      isFree: false,
      attendees: 20,
      imageUrl: "https://i.imgur.com/Abj8U8k.jpg",
    ),
    EventSummary(
      title: "Dance Party III",
      location: "East Java (15 m)",
      isFree: true,
      attendees: 324,
      imageUrl: "https://i.imgur.com/Abj8U8k.jpg",
    ),
    EventSummary(
      title: "Dance Party III",
      location: "East Java (15 m)",
      isFree: true,
      attendees: 34,
      imageUrl: "https://i.imgur.com/Abj8U8k.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Manage Events",
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 28),
        ),
        centerTitle: true,
        leading: const BackButton(),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToggleTab(
              isUpcoming: isUpcoming,
              onToggle: () {
                setState(() {
                  isUpcoming = !isUpcoming;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (_, index) {
                  return EventCard(
                    event: events[index],
                    onTap: () {
                      Get.toNamed(Routes.instructorEventDetails);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final EventSummary event;
  final void Function()? onTap;
  const EventCard({super.key, required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(event.location,
                          style: Theme.of(context).textTheme.labelSmall),
                      const SizedBox(width: 8),
                      Text(
                        event.isFree ? 'Free' : 'Paid',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: event.isFree
                                  ? AppColors.green
                                  : AppColors.secondary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("+${event.attendees} attendees",
                      style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                event.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggleTab extends StatelessWidget {
  final bool isUpcoming;
  final VoidCallback onToggle;

  const ToggleTab({
    super.key,
    required this.isUpcoming,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.liteGray,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          _buildTab("Upcoming", isUpcoming, () => onToggle()),
          _buildTab("Past", !isUpcoming, () => onToggle()),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool selected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 42,
          margin: selected ? EdgeInsets.all(6) : EdgeInsets.all(0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
