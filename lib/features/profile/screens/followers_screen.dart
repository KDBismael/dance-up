import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/follower_users_card.dart';
import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isNoFollowers = false;

    return BaseProfileSubPage(
      appBarTitle: "Followers",
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: isNoFollowers
            ? const Center(
                child: Text(
                  "You don't have any dance followers yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 20, // Replace with actual number of followers
                itemBuilder: (context, index) {
                  return FollowerUsersCard(
                    fullName: 'Alice Smith',
                    userName: 'smith12',
                    imageLink: 'https://i.pravatar.cc/300',
                    buttonColor: AppColors.accent,
                    buttonText: 'follow',
                    onButtonPressed: () {},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
              ),
      ),
    );
  }
}
