import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/profile/components/base_profile_sub_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteDanceVenue extends StatelessWidget {
  const FavoriteDanceVenue({super.key});

  @override
  Widget build(BuildContext context) {
    final venues = Get.arguments['venues'] as List;
    return BaseProfileSubPage(
      appBarTitle: "Favorite Dance Venues",
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: venues.isEmpty
            ? Center(
                child: Text(
                  "No favorited vanues",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.blackGray),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: venues.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Column(
                      children: [
                        const FavoriteVenueCard(),
                        const SizedBox(height: 8),
                        if (index != venues.length - 1)
                          const Divider(color: Color(0xFFE2DBDB))
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class FavoriteVenueCard extends StatelessWidget {
  const FavoriteVenueCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DANCE VENUE 1',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.black),
            ),
            Text(
              'Rue 187, North America',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.blackGray),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              "4.2",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.black),
            ),
            const Icon(Icons.star, size: 12)
          ],
        )
      ],
    );
  }
}
