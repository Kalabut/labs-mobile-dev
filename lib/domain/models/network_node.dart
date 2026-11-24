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

  factory NetworkNode.fromJson(Map<String, dynamic> json) {
    return NetworkNode(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      ipAddress: json['ipAddress'] as String,
      rssiDbm: json['rssiDbm'] as int,
      pingMs: json['pingMs'] as int,
      channelLoad: json['channelLoad'] as int,
      clientsCount: json['clientsCount'] as int,
      status: NodeStatus.values.byName(json['status'] as String),
    );
  }

  final String id;
  final String name;
  final String location;
  final String ipAddress;
  final int rssiDbm;
  final int pingMs;
  final int channelLoad;
  final int clientsCount;
  final NodeStatus status;

  NetworkNode copyWith({
    String? name,
    String? location,
    String? ipAddress,
    int? rssiDbm,
    int? pingMs,
    int? channelLoad,
    int? clientsCount,
    NodeStatus? status,
  }) {
    return NetworkNode(
      id: id,
      name: name ?? this.name,
      location: location ?? this.location,
      ipAddress: ipAddress ?? this.ipAddress,
      rssiDbm: rssiDbm ?? this.rssiDbm,
      pingMs: pingMs ?? this.pingMs,
      channelLoad: channelLoad ?? this.channelLoad,
      clientsCount: clientsCount ?? this.clientsCount,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'ipAddress': ipAddress,
      'rssiDbm': rssiDbm,
      'pingMs': pingMs,
      'channelLoad': channelLoad,
      'clientsCount': clientsCount,
      'status': status.name,
    };
  }
}

const List<NetworkNode> defaultNetworkNodes = [
  NetworkNode(
    id: 'node-1',
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
    id: 'node-2',
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
    id: 'node-3',
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
    id: 'node-4',
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
