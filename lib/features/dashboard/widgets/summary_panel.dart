import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'summary_card.dart'; // <-- Import the separated card

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView( // ✅ scrollable wrapper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                const Text(
                  "Today's Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.accentPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.auto_graph, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Get Report',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),

            // Summary grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SummaryCard(
                  title: "Today's Users",
                  value: "17",
                  valueColor: AppTheme.accentPurple,
                ),
                SummaryCard(
                  title: "Today's Withdrawals",
                  value: "8",
                  valueColor: AppTheme.accentYellow,
                ),
                SummaryCard(
                  title: "Withdrawal Amount",
                  value: "\$940",
                  valueColor: AppTheme.accentYellow,
                ),
                SummaryCard(
                  title: "Verification Requests",
                  value: "5",
                  valueColor: AppTheme.accentBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
