import 'package:flutter/material.dart';

class DeviceVariables {
  final double screenWidth;
  final double screenHeight;
  final double resolution;
  final ThemeData theme;

  DeviceVariables({
    required this.screenWidth,
    required this.screenHeight,
    required this.resolution,
    required this.theme,
  });

  factory DeviceVariables.fromBuildContext(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final Size size = mediaQuery.size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;
    final double resolution = mediaQuery.devicePixelRatio;
    final ThemeData theme = Theme.of(context);

    return DeviceVariables(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      resolution: resolution,
      theme: theme,
    );
  }
}
