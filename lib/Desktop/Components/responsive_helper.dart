import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getResponsiveWidth(BuildContext context, {
    double mobile = 1.0,
    double tablet = 0.8,
    double desktop = 0.6,
  }) {
    if (isMobile(context)) {
      return MediaQuery.of(context).size.width * mobile;
    } else if (isTablet(context)) {
      return MediaQuery.of(context).size.width * tablet;
    } else {
      return MediaQuery.of(context).size.width * desktop;
    }
  }

  static double getResponsivePadding(BuildContext context, {
    double mobile = 16.0,
    double tablet = 24.0,
    double desktop = 32.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  static int getResponsiveColumns(BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  static double getResponsiveFontSize(BuildContext context, {
    double mobile = 14.0,
    double tablet = 16.0,
    double desktop = 18.0,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet;
    } else {
      return desktop;
    }
  }

  static Widget buildResponsiveLayout({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    } else if (isDesktop(context) && desktop != null) {
      return desktop;
    } else {
      return mobile;
    }
  }
}












