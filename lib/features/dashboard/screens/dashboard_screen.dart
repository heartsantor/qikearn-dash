import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/user_tab.dart';
import '../widgets/summary_panel.dart';
import '../widgets/metrics_row.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DashboardContent(),
      ),
    );
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  int tabIndex = 0;
  final tabs = ['Users', 'Withdrawals', 'Verifications'];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left content panel
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sticky Top
                    const Text(
                      '04:22 AM',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text('Tuesday, June 24'),
                    const SizedBox(height: 20),

                    // Metrics Row
                    const DashboardMetricsRow(),
                    const SizedBox(height: 20),

                    // Main Content Area
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Tabs
                            Row(
                              children: List.generate(tabs.length, (index) {
                                final isSelected = index == tabIndex;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ChoiceChip(
                                    label: Text(tabs[index]),
                                    selected: isSelected,
                                    onSelected: (_) => setState(() => tabIndex = index),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 16),

                            // Scrollable User List
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (tabIndex == 0) const UserTab(),
                                    if (tabIndex == 1)
                                      const Text('Withdrawals Tab (Placeholder)',
                                          style: TextStyle(color: Colors.white)),
                                    if (tabIndex == 2)
                                      const Text('Verifications Tab (Placeholder)',
                                          style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // Right summary panel
            const SizedBox(
              width: 320,
              child: Padding(
                padding: EdgeInsets.only(top: 16, right: 16),
                child: SummaryPanel(),
              ),
            ),
          ],
        );
      },
    );
  }

}
