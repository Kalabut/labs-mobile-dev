import 'package:flutter/material.dart';
import '../models/network_node.dart';
import '../theme/app_theme.dart';
import '../widgets/network_node_card.dart';
import '../widgets/network_summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final onlineNodes = mockNetworkNodes
        .where((node) => node.status != NodeStatus.offline)
        .toList();
    final totalClients = mockNetworkNodes.fold<int>(
      0,
      (sum, node) => sum + node.clientsCount,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('NetPulse • Мережа'),
        actions: [
          IconButton(
            tooltip: 'Профіль',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;
          final double padding = isTablet ? 24 : 16;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NetworkSummaryCard(
                  onlineCount: onlineNodes.length,
                  totalCount: mockNetworkNodes.length,
                  avgPingMs: 34,
                  totalClients: totalClients,
                ),
                const SizedBox(height: 20),
                Text(
                  'Мережеві вузли (${mockNetworkNodes.length})',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 12),
                if (isTablet)
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mockNetworkNodes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 136,
                    ),
                    itemBuilder: (context, index) {
                      return NetworkNodeCard(node: mockNetworkNodes[index]);
                    },
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mockNetworkNodes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return NetworkNodeCard(node: mockNetworkNodes[index]);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
