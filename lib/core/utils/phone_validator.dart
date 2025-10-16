// lib/utils/phone_validator.dart
class PhoneValidator {
  // Очистка номера от масочных символов
  static String cleanPhoneNumber(String maskedPhone) {
    return maskedPhone.replaceAll(RegExp(r'[^\d]'), '');
  }

  // Проверка валидности российского номера
  static bool isValidRussianPhone(String cleanPhone) {
    if (cleanPhone.length != 11) return false;

    final regex = RegExp(r'^79\d{9}$');
    return regex.hasMatch(cleanPhone);
  }

  // Форматирование номера для отображения
  static String formatPhone(String cleanPhone) {
    if (cleanPhone.length != 11) return cleanPhone;

    return '+7 (${cleanPhone.substring(1, 4)}) ${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7, 9)}-${cleanPhone.substring(9)}';
  }

  // Получение маскированного номера
  static String getMaskedPhone(String cleanPhone) {
    if (cleanPhone.length != 11) return cleanPhone;

    return '+7-${cleanPhone.substring(1, 4)}-${cleanPhone.substring(4, 7)}-${cleanPhone.substring(7, 9)}-${cleanPhone.substring(9)}';
  }
}