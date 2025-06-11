import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:dance_up/features/profile/components/follower_users_card.dart';
import 'package:dance_up/routes/get_pages.dart';
import 'package:flutter/material.dart';

class PartnersScreen extends StatelessWidget {
  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isNoPartners = false;

    return BaseProfileSubPage(
      appBarTitle: "Dance Partners",
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: isNoPartners
            ? const Center(
                child: Text(
                  "You don't have any dance partners yet.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
            : ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5, // Replace with actual number of partners
                itemBuilder: (context, index) {
                  return FollowerUsersCard(
                    fullName: 'Alice Smith',
                    userName: 'smith12',
                    imageLink: 'https://i.pravatar.cc/300',
                    buttonText: 'Remove',
                    onButtonPressed: () {},
                    onProfileTapped: () {
                      // Navigate to partner's profile
                      Navigator.pushNamed(
                        context,
                        Routes.guestProfile,
                        arguments: 'smith12',
                      );
                    },
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
