import 'package:dance_up/core/components/custom_button.dart';
import 'package:flutter/material.dart';

class EventPreviewCard extends StatelessWidget {
  const EventPreviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            height: 3,
            width: 41,
            color: const Color(0xFFE0DFE2),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  key: UniqueKey(),
                  "https://images.unsplash.com/photo-1592194996308-7b43878e84a6",
                  height: 120,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Paid Event",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Dance Party II",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "24 Jun 2025",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Slasa",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          CustomButton(text: "Join Now", borderRadius: 50, onPressed: () {})
        ],
      ),
    );
  }
}
