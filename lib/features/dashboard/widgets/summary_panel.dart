import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'summary_card.dart'; // <-- Import the separated card

class SummaryPanel extends StatelessWidget {
  final int todayUsers;
  final int todayWithdrawals;
  final String todayWithdrawalAmount;
  final int todayVerificationRequests;

  const SummaryPanel({
    super.key,
    required this.todayUsers,
    required this.todayWithdrawals,
    required this.todayWithdrawalAmount,
    required this.todayVerificationRequests,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Expanded(
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
                  child: const Text(
                    'Get Report',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Grid of cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SummaryCard(
                  title: "Today's Users",
                  value: "$todayUsers",
                  valueColor: AppTheme.accentPurple,
                ),
                SummaryCard(
                  title: "Today's Withdrawals",
                  value: "$todayWithdrawals",
                  valueColor: AppTheme.accentYellow,
                ),
                SummaryCard(
                  title: "Withdrawal Amount",
                  value: todayWithdrawalAmount,
                  valueColor: AppTheme.accentYellow,
                ),
                SummaryCard(
                  title: "Verification Requests",
                  value: "$todayVerificationRequests",
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
