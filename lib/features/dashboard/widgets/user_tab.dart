import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class UserTab extends StatefulWidget {
  final List<Map<String, dynamic>> allUsers;
  final List<Map<String, dynamic>> todayUsers;

  const UserTab({super.key, required this.allUsers, required this.todayUsers});

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> with TickerProviderStateMixin {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // prevent infinite height
      children: [
        TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accentBlue,
          labelColor: Colors.white,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          tabs: const [
            Tab(text: "Today's Users"),
            Tab(text: "All Users"),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45, // or 0.5, 0.6 etc
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildUserList(widget.todayUsers),
              _buildUserList(widget.allUsers),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserList(List<Map<String, dynamic>> users) {
    if (users.isEmpty) {
      return const Center(
        child: Text(
          'No users found.',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
      );
    }

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      // ensure full scroll
      padding: const EdgeInsets.only(bottom: 40, top: 8),
      // enough bottom space
      itemCount: users.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final user = users[index];
        final name = "${user['first_name']} ${user['last_name']}";
        final joinedDate = (user['created_at'] ?? '')
            .toString()
            .split('T')
            .first;
        final initials = _getInitials(user['first_name'], user['last_name']);

        return UserCard(name: name, joinedDate: joinedDate, initials: initials);
      },
    );
  }

  String _getInitials(String? first, String? last) {
    final f = first?.isNotEmpty == true ? first![0] : '';
    final l = last?.isNotEmpty == true ? last![0] : '';
    return (f + l).toUpperCase();
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String joinedDate;
  final String initials;

  const UserCard({
    super.key,
    required this.name,
    required this.joinedDate,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppTheme.accentBlue,
            child: Text(
              initials,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Column(
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
                'Joined: $joinedDate',
                style: const TextStyle(fontSize: 10, color: Colors.white70),
              ),
            ],
          ),
          const Spacer(),
          const Text(
            'Active',
            style: TextStyle(
              fontSize: 12,
              color: AppTheme.accentGreen,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
