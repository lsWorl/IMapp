import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';

// 加密
Future<String> encodeString(String content) async {
  final publicPem = await rootBundle.loadString('key/public.pem');
  dynamic publicKey = RSAKeyParser().parse(publicPem);

  final encrypter = Encrypter(RSA(publicKey: publicKey));

  return encrypter.encrypt(content).base64;
}

// 解密
Future<String> decodeString(String content) async {
  final privatePem = await rootBundle.loadString('key/private.pem');
  dynamic privateKey = RSAKeyParser().parse(privatePem);

  final encrypter = Encrypter(RSA(privateKey: privateKey));
  return encrypter.decrypt(Encrypted.fromBase64(content));
}
