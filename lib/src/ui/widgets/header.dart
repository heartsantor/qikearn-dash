import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final timeFormat = DateFormat('hh:mm a');
    final dateFormat = DateFormat('EEEE, MMMM d');

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: const Color(0xFF2C2C3E), // Dark background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                timeFormat.format(now), // Placeholder for functional timer
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dateFormat.format(now),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}