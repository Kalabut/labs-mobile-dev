enum NodeStatus { online, warning, offline }

class NetworkNode {
  const NetworkNode({
    required this.id,
    required this.name,
    required this.location,
    required this.ipAddress,
    required this.rssiDbm,
    required this.pingMs,
    required this.channelLoad,
    required this.clientsCount,
    required this.status,
  });

  final String id;
  final String name;
  final String location;
  final String ipAddress;
  final int rssiDbm;
  final int pingMs;
  final int channelLoad;
  final int clientsCount;
  final NodeStatus status;
}

const List<NetworkNode> mockNetworkNodes = [
  NetworkNode(
    id: 'node-01',
    name: 'Головний роутер',
    location: 'Вітальня',
    ipAddress: '192.168.1.1',
    rssiDbm: -42,
    pingMs: 4,
    channelLoad: 34,
    clientsCount: 9,
    status: NodeStatus.online,
  ),
  NetworkNode(
    id: 'node-02',
    name: 'Mesh-вузол #1',
    location: 'Робоча зона',
    ipAddress: '192.168.1.12',
    rssiDbm: -56,
    pingMs: 11,
    channelLoad: 58,
    clientsCount: 5,
    status: NodeStatus.online,
  ),
  NetworkNode(
    id: 'node-03',
    name: 'Mesh-вузол #2',
    location: 'Спальня',
    ipAddress: '192.168.1.18',
    rssiDbm: -74,
    pingMs: 89,
    channelLoad: 82,
    clientsCount: 3,
    status: NodeStatus.warning,
  ),
  NetworkNode(
    id: 'node-04',
    name: 'IoT-шлюз Zigbee',
    location: 'Кухня',
    ipAddress: '192.168.1.25',
    rssiDbm: -95,
    pingMs: 0,
    channelLoad: 0,
    clientsCount: 0,
    status: NodeStatus.offline,
  ),
];
