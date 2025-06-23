import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("Today's Summary", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Spacer(),
              Chip(
                label: Text('Get Report', style: TextStyle(color: Colors.white)),
                backgroundColor: AppTheme.accentPurple,
              )
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              SummaryCard(title: "Today's Users", value: "17"),
              SummaryCard(title: "Today's Withdrawals", value: "8"),
              SummaryCard(title: "Withdrawal Amount", value: "\$940", highlight: true),
              SummaryCard(title: "Verification Requests", value: "5"),
            ],
          )
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final bool highlight;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: highlight ? AppTheme.accentYellow : Colors.white)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.white60)),
        ],
      ),
    );
  }
}
