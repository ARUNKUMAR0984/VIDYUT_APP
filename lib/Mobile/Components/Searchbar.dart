import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class M_SearchBar extends StatelessWidget {
  const M_SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          const Icon(Ionicons.search_outline, color: Colors.grey, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search for products & services",
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic, color: Colors.grey, size: 22),
            onPressed: () {
              print("Voice search tapped");
            },
          ),
        ],
      ),
    );
  }
}
