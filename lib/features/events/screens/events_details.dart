import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

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
      body: SafeArea(
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
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("Rue 187, North\nAmerica (15 km)",
                                style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),

                        /// Time
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Time :",
                                style: Theme.of(context).textTheme.labelLarge),
                            Text("06-23 at 08:45\n06-23 at 08:45",
                                style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),

                        /// Rate
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Rate :",
                                style: Theme.of(context).textTheme.labelLarge),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.gold, size: 16),
                                const SizedBox(width: 4),
                                Text("0.0",
                                    style:
                                        Theme.of(context).textTheme.bodySmall),
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
                    onTap: () {},
                    child: const _TabItem(label: "Photos (0)", selected: true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const _TabItem(label: "Attendees (15)"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const _TabItem(label: "Reviews (10)"),
                  ),
                ],
              ),
              const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [Text("Fake Text")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tab Widget
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
