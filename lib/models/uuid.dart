import 'dart:math';

String getUniqueId() {
  StringBuffer buf = StringBuffer("");
  for (int i = 0;i < 12;i++) {
    buf.writeCharCode(Random().nextInt(26) + 97);
  }
  return buf.toString();
}