import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/follower_users_card.dart';
import 'package:flutter/material.dart';

class FollowingsScreen extends StatelessWidget {
  const FollowingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isNoFollowings = false;

    return BaseProfileSubPage(
      appBarTitle: "Followings",
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: isNoFollowings
            ? const Center(
                child: Text(
                  "You don't have any dance followings yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10, // Replace with actual number of followings
                itemBuilder: (context, index) {
                  return FollowerUsersCard(
                    fullName: 'Alice Smith',
                    userName: 'smith12',
                    imageLink: 'https://i.pravatar.cc/300',
                    buttonText: 'unfollow',
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
