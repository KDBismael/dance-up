import 'package:dance_up/core/components/custon_modal_bottom_sheet.dart';
import 'package:dance_up/core/theme/colors.dart';
import 'package:dance_up/features/events/components/sort_by_widget.dart';
import 'package:dance_up/features/profile/components/follower_users_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Tabs {
  photos,
  attendees,
  reviews;
}

enum AttendeesSortBy {
  all,
  pastDancers,
  partners,
  followers;

  @override
  String description() {
    switch (this) {
      case AttendeesSortBy.all:
        return "All";
      case AttendeesSortBy.pastDancers:
        return "Past Dancers";
      case AttendeesSortBy.partners:
        return "Partners";
      case AttendeesSortBy.followers:
        return "Followers";
      default:
        throw "Error";
    }
  }
}

class EventDetailsScreen extends StatelessWidget {
  EventDetailsScreen({super.key});
  var selectedTab = Tabs.photos.obs;
  var selectedSortBy = AttendeesSortBy.all.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.08),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Event Details",
                    style: Theme.of(context).textTheme.bodyMedium),
                // if (authPresenter.isLoading.value)
                //   const SizedBox(
                //       height: 12,
                //       width: 12,
                //       child: CircularProgressIndicator())
              ],
            ),
            backgroundColor: AppColors.white,
            centerTitle: false,
            // elevation: 5,
            actions: const [
              Icon(Icons.location_on_outlined),
              SizedBox(width: 16),
              Icon(Icons.share),
              SizedBox(width: 16),
            ],
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Obx(() {
        final haveImages = true;
        final haveAttendees = true;
        final haveReviews = true;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(-4, 0),
                          blurRadius: 4,
                          color: AppColors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer),
                      BoxShadow(
                          offset: const Offset(4, 0),
                          blurRadius: 4,
                          color: AppColors.black.withOpacity(0.3),
                          spreadRadius: 0,
                          blurStyle: BlurStyle.outer),
                      // BoxShadow(
                      //     offset: const Offset(0, 4),
                      //     blurRadius: 4,
                      //     color: AppColors.black.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurStyle: BlurStyle.outer),
                      // BoxShadow(
                      //     offset: const Offset(0, -4),
                      //     blurRadius: 4,
                      //     color: AppColors.black.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurStyle: BlurStyle.outer),
                    ],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/1.jpg",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Jaydon Mango",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontSize: 20)),
                          Text("Organizer",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppColors.blackGray)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      // BoxShadow(
                      //     offset: const Offset(-4, 0),
                      //     blurRadius: 4,
                      //     color: AppColors.black.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurStyle: BlurStyle.outer),
                      // BoxShadow(
                      //     offset: const Offset(4, 0),
                      //     blurRadius: 4,
                      //     color: AppColors.black.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurStyle: BlurStyle.outer),
                      BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          color: AppColors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.outer),
                      // BoxShadow(
                      //     offset: const Offset(0, -4),
                      //     blurRadius: 4,
                      //     color: AppColors.black.withOpacity(0.3),
                      //     spreadRadius: 0,
                      //     blurStyle: BlurStyle.outer),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title & Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dance Party III",
                              style: Theme.of(context).textTheme.titleLarge),
                          Text("Paid",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: AppColors.secondary)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text("Batchata",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: AppColors.accent)),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Location
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("location :",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              Text("Rue 187, North\nAmerica (15 km)",
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),

                          /// Time
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Time :",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              Text("06-23 at 08:45\n06-23 at 08:45",
                                  style:
                                      Theme.of(context).textTheme.labelSmall),
                            ],
                          ),

                          /// Rate
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Rate :",
                                  style:
                                      Theme.of(context).textTheme.labelLarge),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: AppColors.gold, size: 16),
                                  const SizedBox(width: 4),
                                  Text("0.0",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        selectedTab.value = Tabs.photos;
                      },
                      child: _TabItem(
                          label: "Photos (0)",
                          selected: selectedTab.value == Tabs.photos),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedTab.value = Tabs.attendees;
                      },
                      child: _TabItem(
                          label: "Attendees (15)",
                          selected: selectedTab.value == Tabs.attendees),
                    ),
                    GestureDetector(
                      onTap: () {
                        selectedTab.value = Tabs.reviews;
                      },
                      child: _TabItem(
                        label: "Reviews (10)",
                        selected: selectedTab.value == Tabs.reviews,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: selectedTab.value == Tabs.photos
                          ? Column(
                              children: [
                                if (!haveImages)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 60),
                                    child: Text(
                                      "No photo Yet",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                              color: AppColors.blackGray),
                                    ),
                                  ),
                                if (haveImages) ImageGrid()
                              ],
                            )
                          : selectedTab.value == Tabs.attendees
                              ? Attendees(
                                  haveAttendees: haveAttendees,
                                  selectedSortBy: selectedSortBy,
                                )
                              : Column(
                                  children: [
                                    if (!haveReviews)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 60),
                                        child: Text(
                                          "No review yet",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  color: AppColors.blackGray),
                                        ),
                                      ),
                                    if (haveReviews)
                                      ListView.separated(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return const ReviewCard(
                                            userName: "Alexa Barners",
                                            date: "21 Jun 2025",
                                            rating: 4.5,
                                            comment:
                                                "Absolutely love this event !...",
                                            avatarImageUrl: null,
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 10),
                                      )
                                  ],
                                ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Attendees extends StatelessWidget {
  const Attendees({
    super.key,
    required this.haveAttendees,
    required this.selectedSortBy,
  });

  final bool haveAttendees;
  final Rx<AttendeesSortBy> selectedSortBy;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!haveAttendees)
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              "No attendees yet",
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.blackGray),
            ),
          ),
        if (haveAttendees)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedSortBy.value.description(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 20),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      backgroundColor: Colors.white, // light background
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      showCustomModalBottomSheet(
                        context: context,
                        child: SortByWidget<AttendeesSortBy>(
                          sorby: AttendeesSortBy.values,
                          selectedItem: selectedSortBy.value,
                          onTap: (p0) {
                            selectedSortBy.value = p0;
                          },
                          labelBuilder: (p) {
                            return p.description();
                          },
                        ),
                      );
                    },
                    icon: const Text(
                      "Sort by",
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    label: const Icon(Icons.sort,
                        size: 18, color: AppColors.accent),
                  )
                ],
              ),
              const SizedBox(height: 10),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return FollowerUsersCard(
                    fullName: 'Alice Manuer',
                    userName: 'smith12',
                    imageLink: 'https://i.pravatar.cc/300',
                    buttonColor: AppColors.accent,
                    buttonText: 'See',
                    onButtonPressed: () {},
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
              )
            ],
          )
      ],
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool selected;

  const _TabItem({
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 11.5),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: selected ? AppColors.black : AppColors.blackGray),
            maxLines: 1,
          ),
        ),
        if (selected)
          Container(
            height: 2,
            width: 65,
            color: AppColors.black,
          )
      ],
    );
  }
}

class ImageGrid extends StatelessWidget {
  const ImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      'https://images.unsplash.com/photo-1592194996308-7b43878e84a6',
      'https://st2.depositphotos.com/4218696/11338/i/450/depositphotos_113383240-stock-photo-asian-dance-group-in-flower.jpg',
      'https://images.unsplash.com/photo-1602067340370-1a26c281caae',
      'https://images.unsplash.com/photo-1592194996308-7b43878e84a6',
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: imageUrls.length,
      padding: const EdgeInsets.only(top: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String userName;
  final String date;
  final double rating;
  final String comment;
  final String? avatarImageUrl;

  const ReviewCard({
    super.key,
    required this.userName,
    required this.date,
    required this.rating,
    required this.comment,
    this.avatarImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                avatarImageUrl != null ? NetworkImage(avatarImageUrl!) : null,
            child: avatarImageUrl == null
                ? const Icon(Icons.person, color: Colors.grey, size: 30)
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating.floor()
                          ? Icons.star // Full star
                          : index < rating
                              ? Icons.star_half // Half star
                              : Icons.star_border, // Empty star
                      color: AppColors.gold, // Star color
                      size: 20,
                    );
                  }),
                ),
                const SizedBox(height: 8), // Spacing below stars

                Text(
                  comment,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.blackGray),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
