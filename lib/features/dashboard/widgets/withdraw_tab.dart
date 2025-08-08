import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class WithdrawTab extends StatefulWidget {
  final List<Map<String, dynamic>> allWithdrawals;
  final List<Map<String, dynamic>> todayWithdrawals;

  const WithdrawTab({
    super.key,
    required this.allWithdrawals,
    required this.todayWithdrawals,
  });

  @override
  State<WithdrawTab> createState() => _WithdrawTabState();
}

class _WithdrawTabState extends State<WithdrawTab>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentYellow,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: "Today's Withdrawals"),
            Tab(text: "All Withdrawals"),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45, // or 0.5, 0.6 etc
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildList(widget.todayWithdrawals),
              _buildList(widget.allWithdrawals),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildList(List<Map<String, dynamic>> list) {
    if (list.isEmpty) {
      return const Center(
        child: Text(
          'No withdrawals.',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      );
    }

    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = list[index];
        final amount = item['amount']?.toString() ?? '0';
        final name = item['method'] ?? 'Unknown';
        final date = item['created_at']?.toString().split('T').first ?? '';

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.accentYellow.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const Icon(Icons.currency_exchange, color: Colors.yellow),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Date: $date',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '৳$amount',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.accentYellow,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
