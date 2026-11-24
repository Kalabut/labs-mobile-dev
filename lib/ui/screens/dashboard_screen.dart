import 'package:lab1_counter/domain/models/network_node.dart';
import 'package:lab1_counter/domain/repositories/i_network_node_repository.dart';
import 'package:lab1_counter/ui/theme/app_theme.dart';
import 'package:lab1_counter/ui/widgets/network_node_card.dart';
import 'package:lab1_counter/ui/widgets/network_summary_card.dart';
import 'package:lab1_counter/ui/widgets/node_form_dialog.dart';
import 'package:material_ui/material_ui.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({required this.nodeRepository, super.key});

  final INetworkNodeRepository nodeRepository;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<NetworkNode> _nodes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNodes();
  }

  Future<void> _loadNodes() async {
    setState(() => _isLoading = true);
    final nodes = await widget.nodeRepository.getNodes();
    if (!mounted) {
      return;
    }
    setState(() {
      _nodes = nodes;
      _isLoading = false;
    });
  }

  Future<void> _addNode() async {
    final created = await showDialog<NetworkNode>(
      context: context,
      builder: (_) => const NodeFormDialog(),
    );
    if (created == null) {
      return;
    }
    await widget.nodeRepository.addNode(created);
    await _loadNodes();
  }

  Future<void> _editNode(NetworkNode node) async {
    final updated = await showDialog<NetworkNode>(
      context: context,
      builder: (_) => NodeFormDialog(existingNode: node),
    );
    if (updated == null) {
      return;
    }
    await widget.nodeRepository.updateNode(updated);
    await _loadNodes();
  }

  Future<void> _deleteNode(NetworkNode node) async {
    await widget.nodeRepository.deleteNode(node.id);
    await _loadNodes();
  }

  @override
  Widget build(BuildContext context) {
    final onlineNodes = _nodes
        .where((n) => n.status != NodeStatus.offline)
        .toList();
    final totalClients = _nodes.fold<int>(0, (s, n) => s + n.clientsCount);
    final avgPing = onlineNodes.isEmpty
        ? 0
        : onlineNodes.fold<int>(0, (s, n) => s + n.pingMs) ~/
              onlineNodes.length;

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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Додати вузол',
        onPressed: _addNode,
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
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
                        totalCount: _nodes.length,
                        avgPingMs: avgPing,
                        totalClients: totalClients,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Мережеві вузли (${_nodes.length})',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 12),
                      if (isTablet)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _nodes.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                mainAxisExtent: 142,
                              ),
                          itemBuilder: (_, index) {
                            final node = _nodes[index];
                            return NetworkNodeCard(
                              node: node,
                              onEdit: () => _editNode(node),
                              onDelete: () => _deleteNode(node),
                            );
                          },
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _nodes.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 10),
                          itemBuilder: (_, index) {
                            final node = _nodes[index];
                            return NetworkNodeCard(
                              node: node,
                              onEdit: () => _editNode(node),
                              onDelete: () => _deleteNode(node),
                            );
                          },
                        ),
                      const SizedBox(height: 72),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
