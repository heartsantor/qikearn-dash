import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'summary_card.dart'; // <-- Import the separated card

class SummaryPanel extends StatelessWidget {
  const SummaryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        // ✅ scrollable wrapper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                const Expanded(
                  // 👈 Wrap the text in Expanded
                  child: Text(
                    "Today's",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accentPurple,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      SizedBox(width: 4),
                      Text(
                        'Get Report',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
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
