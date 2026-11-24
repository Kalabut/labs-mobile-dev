import 'package:lab1_counter/domain/models/network_node.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:material_ui/material_ui.dart';

class NetworkNodeCard extends StatelessWidget {
  const NetworkNodeCard({
    required this.node,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final NetworkNode node;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  Color get _statusColor => switch (node.status) {
    NodeStatus.online => AppTheme.online,
    NodeStatus.warning => AppTheme.warning,
    NodeStatus.offline => AppTheme.offline,
  };

  String get _statusLabel => switch (node.status) {
    NodeStatus.online => 'Online',
    NodeStatus.warning => 'Навантаження',
    NodeStatus.offline => 'Offline',
  };

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium
        ?.copyWith(fontWeight: FontWeight.w600);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
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
                        style: titleStyle,
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
                const SizedBox(width: 6),
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
                if (onEdit != null || onDelete != null)
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    iconSize: 20,
                    onSelected: (value) {
                      if (value == 'edit') {
                        onEdit?.call();
                      } else if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Редагувати')),
                      PopupMenuItem(value: 'delete', child: Text('Видалити')),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 12),
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
