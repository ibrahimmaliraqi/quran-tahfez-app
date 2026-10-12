import 'package:flutter/material.dart';

class ManagerDashboardView extends StatelessWidget {
  const ManagerDashboardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const Center(
        child: Text('Dashboard View'),
      ),
    );
  }
}
