import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        UserCard(name: 'John Doe', joinedDate: '2024-05-10', initials: 'JD'),
        SizedBox(height: 12),
        UserCard(name: 'Alice W.', joinedDate: '2024-03-22', initials: 'AW'),
      ],
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String joinedDate;
  final String initials;

  const UserCard({
    super.key,
    required this.name,
    required this.joinedDate,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
            child: Text(initials, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Joined: $joinedDate',
                style: const TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'Active',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.accentGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
