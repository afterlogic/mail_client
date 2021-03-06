import 'package:crypto_model/crypto_model.dart';
import 'package:crypto_worker/crypto_worker.dart';

abstract class PgpWorker {
  PgpEncryptDecrypt encryptDecrypt(
    String sender,
    List<String> recipient,
  );

  Future<List<PgpKey>> createKeyPair(
    String name,
    int length,
    String email,
    String password,
  );

  Future<List<PgpKey>> parseKey(
    String text,
  );

  Future<bool> checkKeyPassword(String key, String password);

  EncryptType encryptType(String text);

  Future<String> encryptSymmetric(String text, String password);

  stop();
}
