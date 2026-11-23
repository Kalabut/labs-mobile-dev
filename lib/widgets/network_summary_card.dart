import 'package:lab1_counter/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

class NetworkSummaryCard extends StatelessWidget {
  const NetworkSummaryCard({
    required this.onlineCount,
    required this.totalCount,
    required this.avgPingMs,
    required this.totalClients,
    super.key,
  });

  final int onlineCount;
  final int totalCount;
  final int avgPingMs;
  final int totalClients;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _SummaryMetric(
              label: 'Вузли онлайн',
              value: '$onlineCount / $totalCount',
              color: AppTheme.online,
            ),
            _SummaryMetric(
              label: 'Середній пінг',
              value: '$avgPingMs мс',
              color: AppTheme.accent,
            ),
            _SummaryMetric(
              label: 'Клієнти',
              value: '$totalClients',
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(color: color, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}
