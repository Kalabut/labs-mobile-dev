import 'package:material_ui/material_ui.dart';
import 'package:lab1_counter/models/network_node.dart';
import 'package:lab1_counter/theme/app_theme.dart';

class NetworkNodeCard extends StatelessWidget {
  const NetworkNodeCard({required this.node, super.key});

  final NetworkNode node;

  Color get _statusColor => switch (node.status) {
    NodeStatus.online => AppTheme.online,
    NodeStatus.warning => AppTheme.warning,
    NodeStatus.offline => AppTheme.offline,
  };

  String get _statusLabel => switch (node.status) {
    NodeStatus.online => 'Online',
    NodeStatus.warning => 'Високе навантаження',
    NodeStatus.offline => 'Offline',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.router_outlined, color: _statusColor),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${node.location} • ${node.ipAddress}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _statusLabel,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: _statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TelemetryChip(icon: Icons.wifi, label: '${node.rssiDbm} dBm'),
                _TelemetryChip(icon: Icons.speed, label: '${node.pingMs} мс'),
                _TelemetryChip(
                  icon: Icons.bar_chart,
                  label: '${node.channelLoad}%',
                ),
                _TelemetryChip(
                  icon: Icons.devices,
                  label: '${node.clientsCount}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TelemetryChip extends StatelessWidget {
  const _TelemetryChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppTheme.textSecondary),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
