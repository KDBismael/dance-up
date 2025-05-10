import 'package:dance_up/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BaseProfileSubPage extends StatelessWidget {
  const BaseProfileSubPage(
      {super.key, required this.child, required this.appBarTitle});

  final String appBarTitle;
  final Widget child;

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
            title: Text(appBarTitle,
                style: Theme.of(context).textTheme.bodyMedium),
            backgroundColor: AppColors.white,
            centerTitle: false,
            // elevation: 5,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}
