import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DashboardMetricsRow extends StatelessWidget {
  const DashboardMetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          MetricCard(
            title: 'Total Revenue',
            value: '\$48.9k',
            icon: Icons.attach_money,
            color: Colors.green,
          ),
          SizedBox(width: 16),
          MetricCard(
            title: 'Withdrawals',
            value: '21',
            icon: Icons.account_balance_wallet,
            color: Colors.orange,
          ),
          SizedBox(width: 16),
          MetricCard(
            title: 'In Progress',
            value: '24',
            icon: Icons.sync,
            color: Colors.blue,
          ),
          SizedBox(width: 16),
          MetricCard(
            title: 'Total Users',
            value: '1,254',
            icon: Icons.people,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(title,
                  style: const TextStyle(fontSize: 12, color: Colors.white60)),
            ],
          ),
        ],
      ),
    );
  }
}
