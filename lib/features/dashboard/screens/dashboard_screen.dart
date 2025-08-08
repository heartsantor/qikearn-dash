import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/services/socket_service.dart';
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
  bool isSocketConnected = false;
  bool isConnecting = false;
  final tabs = ['Withdrawals', 'Users'];

  String totalEarnings = "\$0.00";
  int withdrawals = 0;
  int users = 0;

  int todayUsers = 0;
  int todayWithdrawals = 0;
  String todayWithdrawalAmount = "\$0.00";
  int todayVerificationRequests = 0;

  List<Map<String, dynamic>> allUsers = [];
  List<Map<String, dynamic>> todayUsersList = [];

  @override
  void initState() {
    super.initState();
    WakelockPlus.enable();
    connectSocket();
  }

  void connectSocket() {
    setState(() => isConnecting = true);

    SocketService().connect(
      onConnected: () {
        setState(() {
          isSocketConnected = true;
          isConnecting = false;
        });
        print("🔄 Socket Connected");
      },
      onDisconnected: (msg) {
        setState(() {
          isSocketConnected = false;
          isConnecting = false;
        });
        print("🔌 Disconnected: $msg");
      },
      onError: (err) {
        setState(() {
          isSocketConnected = false;
          isConnecting = false;
        });
        print("❗ Socket Error: $err");
      },
      eventListeners: {
        "today_task_and_earning_stats": (data) {
          print("📊 Stats: $data");
          setState(() {
            totalEarnings = data['total_earning_today'] ?? "\$0.00";
            todayWithdrawalAmount =
                data['total_earning_today'] ?? "\$0.00"; // same value if used
          });
        },
        "today_joining_kamla_event": (data) {
          print("👥 Today Kamla: $data");
          setState(() {
            todayUsers = data.length;
            todayUsersList = List<Map<String, dynamic>>.from(data);
          });
        },
        "today_withdraw_list": (data) {
          print("💸 Today Withdraws: $data");
          setState(() {
            todayWithdrawals = data.length;
          });
        },
        "irregular_activities_today_event": (data) {
          // 🛂 Use this for verifications (if you have another event for this, use that)
          print("🔎 Today's Verifications: $data");
          setState(() {
            todayVerificationRequests = data.length;
          });
        },
        "all_kamla_event": (data) {
          setState(() {
            allUsers = List<Map<String, dynamic>>.from(data);
            users = data.length;
          });
        },
        "all_withdraw_list": (data) {
          setState(() => withdrawals = data.length);
        },
      },
    );
  }

  void disconnectSocket() {
    SocketService().disconnect();
    setState(() {
      isSocketConnected = false;
      isConnecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final now = DateTime.now();
        final timeString = DateFormat('hh:mm a').format(now);
        final dateString = DateFormat('EEEE, MMMM d').format(now);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left panel
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Row(
                          children: [
                            ElevatedButton.icon(
                              icon: const Icon(Icons.link, size: 18),
                              label: const Text(
                                "Con",
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: isSocketConnected || isConnecting
                                  ? null
                                  : connectSocket,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isSocketConnected
                                    ? Colors.grey
                                    : Colors.green,
                              ),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.link_off, size: 18),
                              label: const Text(
                                "Dis",
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: isSocketConnected || isConnecting
                                  ? disconnectSocket
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    isSocketConnected || isConnecting
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                Icon(
                                  isSocketConnected
                                      ? Icons.circle
                                      : isConnecting
                                      ? Icons.circle_outlined
                                      : Icons.cancel_outlined,
                                  size: 12,
                                  color: isSocketConnected
                                      ? Colors.green
                                      : isConnecting
                                      ? Colors.orange
                                      : Colors.red,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  isSocketConnected
                                      ? "Active"
                                      : isConnecting
                                      ? "Connecting..."
                                      : "Inactive",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSocketConnected
                                        ? Colors.green
                                        : isConnecting
                                        ? Colors.orange
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    DashboardMetricsRow(
                      totalEarnings: totalEarnings,
                      withdrawals: withdrawals,
                      users: users,
                    ),
                    const SizedBox(height: 10),

                    // Tabs and panels
                    Expanded(
                      child: Row(
                        children: [
                          // 🔹 Vertical Icon Tab Bar (Left)
                          Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.cardColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: List.generate(tabs.length, (index) {
                                final isSelected = index == tabIndex;
                                final icon = index == 0
                                    ? Icons.account_balance_wallet
                                    : Icons.people;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      icon,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white54,
                                      size: isSelected ? 28 : 24,
                                    ),
                                    onPressed: () =>
                                        setState(() => tabIndex = index),
                                  ),
                                );
                              }),
                            ),
                          ),

                          const SizedBox(width: 10),

                          // 🔹 Right Side Content Panel
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.cardColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Tab Content
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          if (tabIndex == 0)
                                            const Text(
                                              'Withdrawals Tab (Placeholder)',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          if (tabIndex == 1)
                                            UserTab(
                                              allUsers: allUsers,
                                              todayUsers: todayUsersList,
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
                  ],
                ),
              ),
            ),

            // Right Summary Panel
            SizedBox(
              width: screenWidth * 0.3,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, right: 10),
                child: SummaryPanel(
                  todayUsers: todayUsers,
                  todayWithdrawals: todayWithdrawals,
                  todayWithdrawalAmount: todayWithdrawalAmount,
                  todayVerificationRequests: todayVerificationRequests,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
