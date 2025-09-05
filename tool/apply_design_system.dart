import 'dart:io';

void main() async {
  final libDir = Directory('lib');
  if (!libDir.existsSync()) {
    stderr.writeln('lib/ not found. Run from project root.');
    exit(1);
  }

  final files = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList();

  int edited = 0;
  for (final file in files) {
    final original = await file.readAsString();
    var content = original;

    // Fonts: Inter -> Manrope
    content = content.replaceAll('GoogleFonts.interTextTheme()', 'GoogleFonts.manropeTextTheme()');
    content = content.replaceAll('GoogleFonts.inter(', 'GoogleFonts.manrope(');
    content = content.replaceAll('GoogleFonts.inter\(', 'GoogleFonts.manrope(');

    // Common Material icons -> Ionicons
    content = content.replaceAll('Icons.search', 'Ionicons.search_outline');
    content = content.replaceAll('Icons.keyboard_arrow_down', 'Ionicons.chevron_down_outline');
    content = content.replaceAll('Icons.grid_view', 'Ionicons.grid_outline');
    content = content.replaceAll('Icons.view_list', 'Ionicons.list_outline');
    content = content.replaceAll('Icons.menu', 'Ionicons.menu_outline');
    content = content.replaceAll('Icons.shopping_cart', 'Ionicons.cart_outline');
    content = content.replaceAll(RegExp(r'Icons.person(?!_)'), 'Ionicons.person_outline');
    content = content.replaceAll('Icons.logout', 'Ionicons.log_out_outline');
    content = content.replaceAll('Icons.settings', 'Ionicons.settings_outline');
    content = content.replaceAll('Icons.favorite', 'Ionicons.heart_outline');
    content = content.replaceAll('Icons.home', 'Ionicons.home_outline');
    content = content.replaceAll('Icons.message', 'Ionicons.chatbubbles_outline');
    content = content.replaceAll('Icons.location_on', 'Ionicons.location_outline');
    content = content.replaceAll('Icons.shopping_bag', 'Ionicons.bag_outline');
    content = content.replaceAll('Icons.store', 'Ionicons.storefront_outline');
    content = content.replaceAll('Icons.toggle_on', 'Ionicons.toggle_outline');
    content = content.replaceAll('Icons.lightbulb', 'Ionicons.bulb_outline');
    content = content.replaceAll('Icons.dashboard', 'Ionicons.grid_outline');

    if (content.contains('Ionicons.') && !content.contains("package:ionicons/ionicons.dart")) {
      content = content.replaceFirst(
        RegExp(r"import\s+'package:flutter/material.dart';"),
        "import 'package:flutter/material.dart';\nimport 'package:ionicons/ionicons.dart';",
      );
    }

    if (content != original) {
      await file.writeAsString(content);
      edited++;
    }
  }

  stdout.writeln('Updated $edited files with Manrope + Ionicons.');
}





