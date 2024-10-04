import 'dart:async';
import 'dart:io';

void animasiAsciiText() {
  List<String> text = [
    'H   H  BBBB   DDDD  ',
    'H   H  B   B  D   D ',
    'HHHHH  BBBB   D   D ',
    'H   H  B   B  D   D ',
    'H   H  BBBB   DDDD  ',
    '',
    '  A   N   N  OOOO  ',
    ' A A  NN  N  O   O ',
    'AAAAA N N N  O   O ',
    'A   A N  NN  O   O ',
    'A   A N   N  OOOO  ',
  ];

  int terminalHeight = stdout.terminalLines;
  int terminalWidth = stdout.terminalColumns;

  int textHeight = text.length;
  int textWidth = text[0].length;

  int startRow = terminalHeight;

  Timer.periodic(Duration(milliseconds: 100), (timer) {
    if (startRow <= (terminalHeight - textHeight) ~/ 2) {
      timer.cancel();
    } else {
      stdout.write('\x1B[2J\x1B[0;0H'); // Clear screen
      for (int i = 0; i < textHeight; i++) {
        int row = startRow + i;
        if (row >= 0 && row < terminalHeight) {
          int col = (terminalWidth - textWidth) ~/ 2;
          stdout.write('\x1B[${row};${col}H${text[i]}');
        }
      }
      startRow--;
    }
  });
}