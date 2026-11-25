import 'package:material_ui/material_ui.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: obscureText,
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(hintText: hint, prefixIcon: Icon(icon)),
        ),
      ],
    );
  }
}
