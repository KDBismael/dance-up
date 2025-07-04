import 'package:dance_up/core/components/custom_button.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewModaleBody extends StatefulWidget {
  const ReviewModaleBody({super.key});

  @override
  State<ReviewModaleBody> createState() => _ReviewModaleBodyState();
}

class _ReviewModaleBodyState extends State<ReviewModaleBody> {
  int _rating = 1;
  final TextEditingController _controller = TextEditingController();

  Widget _buildStar(int index) {
    return IconButton(
      onPressed: () {
        setState(() => _rating = index);
      },
      icon: Icon(
        Icons.star,
        color: index <= _rating ? Colors.orange : Colors.grey[300],
        size: 32,
      ),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Review Dance Party III",
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'love it...',
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppColors.blackGray),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) => _buildStar(index + 1)),
        ),
        const SizedBox(height: 24),
        CustomButton(text: "Submit", onPressed: () {}),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Skip",
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: AppColors.blackGray),
          ),
        )
      ],
    );
  }
}
