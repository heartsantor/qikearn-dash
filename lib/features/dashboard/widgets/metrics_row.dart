import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DashboardMetricsRow extends StatelessWidget {
  final String totalEarnings;
  final int withdrawals;
  final int users;

  const DashboardMetricsRow({
    super.key,
    required this.totalEarnings,
    required this.withdrawals,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            title: 'Total Revenue',
            value: totalEarnings,
            icon: Icons.attach_money,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            title: 'Withdrawals',
            value: withdrawals.toString(),
            icon: Icons.account_balance_wallet,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: MetricCard(
            title: 'Total Users',
            value: users.toString(),
            icon: Icons.people,
            color: Colors.purple,
          ),
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
