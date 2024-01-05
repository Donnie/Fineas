import 'package:finease/core/common.dart';
import 'package:finease/pages/home/frame/destinations.dart';
import 'package:finease/pages/home/frame/mobile.dart';
import 'package:finease/pages/home/frame/tablet.dart';
import 'package:finease/parts/export.dart';
import 'package:finease/parts/floating_action.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegionWidget(
      color: context.background,
      child: ScreenTypeLayout.builder(
        mobile: (p0) => HomePageMobile(
          destinations: destinations,
          floatingActionButton: const HomeFloatingActionButtonWidget(),
        ),
        tablet: (p0) => HomePageTablet(
          destinations: destinations,
          floatingActionButton: const HomeFloatingActionButtonWidget(),
        ),
        desktop: (p0) => Container(),
      ),
    );
  }
}