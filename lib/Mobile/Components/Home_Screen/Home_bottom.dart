import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class M_BottomNavBar extends StatefulWidget {
  const M_BottomNavBar({super.key});

  @override
  State<M_BottomNavBar> createState() => _M_BottomNavBarState();
}

class _M_BottomNavBarState extends State<M_BottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Add navigation logic here if needed
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  ),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
          
          
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: "Sell",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: "Orders",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
