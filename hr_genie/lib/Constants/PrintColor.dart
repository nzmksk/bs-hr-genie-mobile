void printRed(String text) {
  print('\x1B[31m$text\x1B[0m');
}

void printGreen(String text) {
  print('\x1B[32m$text\x1B[0m');
}

void printYellow(String text) {
  print('\x1B[33m$text\x1B[0m');
}
