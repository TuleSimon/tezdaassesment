import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  final encrypt.Key key = encrypt.Key.fromUtf8(
      'f3A5g7H9JkLm2Nq8RpStUvWxYz0B4CdE'); // 32 chars for AES-256
  final encrypt.IV iv =
      encrypt.IV.fromUtf8('1234567890123456'); // 16 chars for AES

  String encryptData(String plainText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc, // Ensure consistent cipher mode
      padding: 'PKCS7', // Default padding
    ));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decryptData(String encryptedText) {
    final encrypter = encrypt.Encrypter(encrypt.AES(
      key,
      mode: encrypt.AESMode.cbc,
      padding: 'PKCS7',
    ));
    final decrypted =
        encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: iv);
    return decrypted;
  }
}

// "email": "simon@gmail.com",
// flutter:   "password": "123456Ah"
