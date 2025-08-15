import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class EventDetails {
  final String title;
  final String description;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final String price;
  final String position;
  final String tag;
  final int views;
  final int attendees;
  final double rate;
  final double viewsChange;
  final double attendeesChange;

  EventDetails({
    required this.title,
    required this.description,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.position,
    required this.tag,
    required this.views,
    required this.attendees,
    required this.rate,
    required this.viewsChange,
    required this.attendeesChange,
  });
}

class InstructorEventDetailsScreen extends StatelessWidget {
  const InstructorEventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = EventDetails(
      title: "Dance Party III",
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
      location: "Rue 187, North America",
      startDate: DateTime(2025, 6, 23, 8, 45),
      endDate: DateTime(2025, 6, 23, 8, 45),
      price: "500 \$",
      position: "Outdoor",
      tag: "Batchata",
      views: 424,
      attendees: 4,
      rate: 4.0,
      viewsChange: 15,
      attendeesChange: 45,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
        centerTitle: true,
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatBox(
                  label: "Views",
                  value: "${event.views}",
                  icon: _StatChangeIcon(event.viewsChange),
                ),
                StatBox(
                  label: "Attendees",
                  value: "${event.attendees}",
                  icon: _StatChangeIcon(event.attendeesChange),
                ),
                StatBox(
                  label: "Rate",
                  value: "${event.rate}",
                  icon: const Icon(Icons.star, color: Colors.orange, size: 18),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Description
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Description :",
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 6),
            Text(event.description),

            const SizedBox(height: 16),

            // Info Table
            Wrap(
              runSpacing: 12,
              spacing: 40,
              children: [
                _InfoLine(label: "location", value: event.location),
                _InfoLine(label: "Time", value: _formatDate(event.startDate)),
                _InfoLine(label: "Time", value: _formatDate(event.endDate)),
                _InfoLine(label: "Price", value: event.price),
                _InfoLine(label: "Position", value: event.position),
                _InfoLine(label: "Tags", value: event.tag),
              ],
            ),

            const SizedBox(height: 24),

            // Tiles
            InfoTile(title: "Photos (10)", onTap: () {}),
            const SizedBox(height: 8),
            InfoTile(title: "Attendees (10)", onTap: () {}),
            const SizedBox(height: 8),
            InfoTile(title: "Reviews (2)", onTap: () {}),
            const Spacer(),

            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                      label: "Delete",
                      onPressed: () {},
                      color: Colors.grey.shade300,
                      textColor: Colors.grey),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                      label: "Edit",
                      onPressed: () {},
                      color: Colors.black,
                      textColor: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                      label: "", onPressed: () {}, icon: Icons.remove_red_eye),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const InfoTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.grey.shade100,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Widget? icon;

  const StatBox(
      {super.key, required this.label, required this.value, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.liteGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold)),
              if (icon != null) const SizedBox(width: 4),
              if (icon != null) icon!,
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("$label : ", style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}

class _StatChangeIcon extends StatelessWidget {
  final double change;
  const _StatChangeIcon(this.change);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.arrow_upward, color: Colors.green, size: 14),
        Text("+${change.toStringAsFixed(0)}%",
            style: const TextStyle(color: Colors.green)),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  const _ActionButton({
    required this.label,
    required this.onPressed,
    this.color,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: icon != null
          ? Icon(icon, color: textColor ?? Colors.black)
          : Text(label, style: TextStyle(color: textColor ?? Colors.black)),
    );
  }
}
