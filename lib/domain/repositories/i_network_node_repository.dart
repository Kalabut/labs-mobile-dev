import 'package:lab1_counter/domain/models/network_node.dart';

abstract interface class INetworkNodeRepository {
  Future<List<NetworkNode>> getNodes();
  Future<void> addNode(NetworkNode node);
  Future<void> updateNode(NetworkNode node);
  Future<void> deleteNode(String id);
}
