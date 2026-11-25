import 'package:lab1_counter/domain/models/network_node.dart';
import 'package:material_ui/material_ui.dart';

class NodeFormDialog extends StatefulWidget {
  const NodeFormDialog({this.existingNode, super.key});

  final NetworkNode? existingNode;

  @override
  State<NodeFormDialog> createState() => _NodeFormDialogState();
}

class _NodeFormDialogState extends State<NodeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _locationController;
  late final TextEditingController _ipController;
  late NodeStatus _status;

  @override
  void initState() {
    super.initState();
    final node = widget.existingNode;
    _nameController = TextEditingController(text: node?.name ?? '');
    _locationController = TextEditingController(text: node?.location ?? '');
    _ipController = TextEditingController(
      text: node?.ipAddress ?? '192.168.1.',
    );
    _status = node?.status ?? NodeStatus.online;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _ipController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final existing = widget.existingNode;
    final result = existing != null
        ? existing.copyWith(
            name: _nameController.text.trim(),
            location: _locationController.text.trim(),
            ipAddress: _ipController.text.trim(),
            status: _status,
          )
        : NetworkNode(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: _nameController.text.trim(),
            location: _locationController.text.trim(),
            ipAddress: _ipController.text.trim(),
            rssiDbm: _status == NodeStatus.offline ? -95 : -52,
            pingMs: _status == NodeStatus.offline ? 0 : 12,
            channelLoad: _status == NodeStatus.warning ? 85 : 35,
            clientsCount: _status == NodeStatus.offline ? 0 : 4,
            status: _status,
          );

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingNode != null;
    return AlertDialog(
      title: Text(isEdit ? 'Редагувати вузол' : 'Новий мережевий вузол'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Назва вузла'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Введіть назву' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Локація'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Введіть локацію' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ipController,
                decoration: const InputDecoration(labelText: 'IP-адреса'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Введіть IP-адресу'
                    : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<NodeStatus>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Статус'),
                items: const [
                  DropdownMenuItem(
                    value: NodeStatus.online,
                    child: Text('Online'),
                  ),
                  DropdownMenuItem(
                    value: NodeStatus.warning,
                    child: Text('Високе навантаження'),
                  ),
                  DropdownMenuItem(
                    value: NodeStatus.offline,
                    child: Text('Offline'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Скасувати'),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(isEdit ? 'Зберегти' : 'Додати'),
        ),
      ],
    );
  }
}
