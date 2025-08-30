import 'package:flutter/material.dart';

class M_Home_Categories extends StatelessWidget {
  const M_Home_Categories({super.key});

  final List<Map<String, String>> categories = const [
    {"title": "Lighting", "image": "assets/images/Categories/blubs.jpeg"},
    {"title": "Plugs & Sockets", "image": "assets/images/Categories/plug.png"},
    {"title": "Batteries", "image": "assets/images/Categories/batteries.png"},
    {"title": "Solar", "image": "assets/images/Categories/solar.png"},
    {"title": "Wind", "image": "assets/images/Categories/wind.png"},
    {"title": "Industrial", "image": "assets/images/Categories/industry.png"},
    {"title": "Meters", "image": "assets/images/Categories/meters.png"},
    {"title": "Energy", "image": "assets/images/Categories/energy.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 173 / 74, // width / height ratio
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          width: 173,
          height: 74,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  child: Image.asset(
                    category["image"]!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  category["title"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
