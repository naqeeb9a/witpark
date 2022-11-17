import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:witpark/MVVM/Views/Bookings/booking.dart';
import 'package:witpark/MVVM/Views/Home%20Page/home.dart';
import 'package:witpark/nearby.dart';
import 'package:witpark/MVVM/Views/Profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selecteditem = 0;
  var pages = [const Home(), const Booking(), const Nearby(), const Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: (_selecteditem == 0 || _selecteditem == 2)
              ? Colors.amber
              : Colors.white,
          height: MediaQuery.of(context).size.height * 0.06,
          backgroundColor: (_selecteditem == 0 || _selecteditem == 2)
              ? Colors.white
              : Colors.amber,
          items: const [
            Icon(
              Icons.home,
            ),
            Icon(Icons.book_online),
            Icon(
              Icons.near_me,
            ),
            Icon(Icons.person),
          ],
          onTap: (index) {
            setState(() {
              _selecteditem = index;
            });
          },
          animationDuration: const Duration(milliseconds: 300),
        ),
        body: Center(
          child: pages[_selecteditem],
        ));
  }
}
