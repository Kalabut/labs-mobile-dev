import 'package:material_ui/material_ui.dart';
import 'package:lab1_counter/theme/app_theme.dart';

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    required this.icon,
    required this.title,
    required this.value,
    super.key,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: AppTheme.accent),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppTheme.textSecondary),
        ),
        subtitle: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
