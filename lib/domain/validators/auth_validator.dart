abstract final class AuthValidator {
  static final RegExp _emailRegex = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$',
  );
  static final RegExp _digitRegex = RegExp(r'\d');

  static String? validateName(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return "Введіть ім'я користувача";
    }
    if (trimmed.length < 2) {
      return "Ім'я має містити мінімум 2 символи";
    }
    if (_digitRegex.hasMatch(trimmed)) {
      return "Ім'я не повинно містити цифр";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return 'Введіть електронну пошту';
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Некоректний формат email (потрібен @ та домен)';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final password = value ?? '';
    if (password.isEmpty) {
      return 'Введіть пароль';
    }
    if (password.length < 8) {
      return 'Пароль має містити мінімум 8 символів';
    }
    return null;
  }
}
