import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/user_tab.dart';
import '../widgets/summary_panel.dart';
import '../widgets/metrics_row.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: DashboardContent()));
  }
}

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  int tabIndex = 0;
  final tabs = ['Users', 'Withdrawals'];

  @override
  void initState() {
    super.initState();

    // Ensure wakelock is always re-enabled here too
    WakelockPlus.enable();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        final now = DateTime.now();
        final timeString = DateFormat('hh:mm a').format(now); // 04:22 AM
        final dateString = DateFormat(
          'EEEE, MMMM d',
        ).format(now); // Tuesday, June 24

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left content panel
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Left: Time and Date
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              timeString,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(dateString),
                          ],
                        ),

                        // Right: Icon buttons
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications),
                              tooltip: 'Notifications',
                              onPressed: () {
                                // handle notification
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.settings),
                              tooltip: 'Settings',
                              onPressed: () {
                                // handle settings
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.account_circle),
                              tooltip: 'Profile',
                              onPressed: () {
                                // handle profile
                              },
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Metrics Row
                    const DashboardMetricsRow(),
                    const SizedBox(height: 10),

                    // Main Content Container
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Scrollable Tabs
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(tabs.length, (index) {
                                  final isSelected = index == tabIndex;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ChoiceChip(
                                      label: Text(
                                        tabs[index],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      selected: isSelected,
                                      onSelected: (_) =>
                                          setState(() => tabIndex = index),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Scrollable content
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    if (tabIndex == 0) const UserTab(),
                                    if (tabIndex == 1)
                                      const Text(
                                        'Withdrawals Tab (Placeholder)',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    if (tabIndex == 2)
                                      const Text(
                                        'Verifications Tab (Placeholder)',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Right summary panel
            SizedBox(
              width: screenWidth * 0.3,
              child: Padding(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: SummaryPanel(),
              ),
            ),
          ],
        );
      },
    );
  }
}
