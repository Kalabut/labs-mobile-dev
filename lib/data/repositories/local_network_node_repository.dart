import 'dart:convert';

import 'package:lab1_counter/domain/models/network_node.dart';
import 'package:lab1_counter/domain/repositories/i_network_node_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNetworkNodeRepository implements INetworkNodeRepository {
  static const String _nodesKeyPrefix = 'netpulse_network_nodes_';
  static const String _currentUserKey = 'netpulse_current_user_email';

  String _getKey(SharedPreferences prefs) {
    final email = prefs.getString(_currentUserKey) ?? 'default';
    return '$_nodesKeyPrefix$email';
  }

  Future<void> _saveNodes(
    SharedPreferences prefs,
    List<NetworkNode> nodes,
  ) async {
    final encoded = jsonEncode(nodes.map((n) => n.toJson()).toList());
    await prefs.setString(_getKey(prefs), encoded);
  }

  @override
  Future<List<NetworkNode>> getNodes() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_getKey(prefs));

    if (raw == null) {
      await _saveNodes(prefs, defaultNetworkNodes);
      return List<NetworkNode>.of(defaultNetworkNodes);
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => NetworkNode.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> addNode(NetworkNode node) async {
    final prefs = await SharedPreferences.getInstance();
    final nodes = await getNodes();
    await _saveNodes(prefs, [...nodes, node]);
  }

  @override
  Future<void> updateNode(NetworkNode node) async {
    final prefs = await SharedPreferences.getInstance();
    final nodes = await getNodes();
    final updated = [
      for (final item in nodes)
        if (item.id == node.id) node else item,
    ];
    await _saveNodes(prefs, updated);
  }

  @override
  Future<void> deleteNode(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final nodes = await getNodes();
    final updated = nodes.where((item) => item.id != id).toList();
    await _saveNodes(prefs, updated);
  }
}
