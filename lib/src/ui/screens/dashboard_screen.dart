import 'package:flutter/material.dart';
import 'package:myapp/src/ui/widgets/header.dart';
import 'package:myapp/src/ui/widgets/info_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // Dark background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(), // Your Header widget
            SizedBox(height: 20),
            SingleChildScrollView( // Use SingleChildScrollView for horizontal scrolling
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InfoCard(
                    icon: Icons.attach_money,
                    title: 'Total Revenue',
                    value: '\$48.9k',
                  ),
                  SizedBox(width: 16),
                  InfoCard(
                    icon: Icons.account_balance_wallet,
                    title: 'Total Withdrawals',
                    value: '21',
                    subtitle: '\$1,280.50',
                  ),
                  SizedBox(width: 16),
                  InfoCard(
                    icon: Icons.assignment,
                    title: 'Tasks In Progress',
                    value: '24',
                  ),
                  SizedBox(width: 16),
                  InfoCard(
                    icon: Icons.group,
                    title: 'Total Users',
                    value: '1,254',
                  ),
                ],
              ),
            ),
            // Add other sections like New Withdrawal Requests and Today's Summary here
          ],
        ),
      ),
    );
  }
}