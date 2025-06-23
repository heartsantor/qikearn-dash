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
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: screenWidth),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side content
              SizedBox(
                width: screenWidth - 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sticky top: time + date
                    const Text(
                      '04:22 AM',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text('Tuesday, June 24'),
                    const SizedBox(height: 20),

                    // Sticky metrics row
                    const DashboardMetricsRow(),
                    const SizedBox(height: 20),

                    // Scrollable user list & tab section
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

                            // Scrollable content
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
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),


              const SizedBox(width: 16),
              const SizedBox(
                width: 300,
                child: SummaryPanel(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
