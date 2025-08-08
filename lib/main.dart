import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'core/services/socket_service.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // 👇 This should keep the screen awake
  await WakelockPlus.enable();

  // 👇 Initialize socket connection before app starts
  SocketService().connect(
    onConnected: () => print('✅ Socket connected'),
    onDisconnected: (msg) => print('❌ $msg'),
    onError: (err) => print('🚫 $err'),
    eventListeners: {
      'today_joining_kamla_event': (data) => print('👥 Today Kamla: $data'),
      'today_withdraw_list': (data) => print('💸 Withdraws: $data'),
      'today_task_and_earning_stats': (data) => print('📊 Stats: $data'),
      // add more as needed
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realtime Dashboard',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
