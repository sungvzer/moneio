import 'dart:math';

String getRandomString([int length = 32]) {
  assert(length > 0, "Length needs to be a positive integer");
  Random random;
  try {
    random = Random.secure();
  } catch (e) {
    int seed = DateTime.now().microsecondsSinceEpoch;
    random = Random(seed);
  }
  String characters =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  String randomString = "";
  while (--length >= 0) {
    int index = random.nextInt(62);
    randomString += characters[index];
  }

  return randomString;
}
