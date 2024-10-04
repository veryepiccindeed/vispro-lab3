import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'hbd_ano.dart';

void main() async {
  stdout.write('Masukkan jumlah kembang api yang ingin diledakkan: ');
  final int? jumlahKembangApi = int.tryParse(stdin.readLineSync() ?? '');

  if (jumlahKembangApi == null || jumlahKembangApi <= 0) {
    print('Jumlah tidak valid!');
    return;
  }

  final colors = [
    '\x1B[31m', // Merah
    '\x1B[32m', // Hijau
    '\x1B[33m', // Kuning
    '\x1B[34m', // Biru
    '\x1B[35m', // Magenta
    '\x1B[36m', // Cyan
    '\x1B[37m', // Putih
  ];

  final backgroundColors = [
    '\x1B[41m', // Merah
    '\x1B[42m', // Hijau
    '\x1B[43m', // Kuning
    '\x1B[44m', // Biru
    '\x1B[45m', // Magenta
    '\x1B[46m', // Cyan
    '\x1B[47m', // Putih
  ];

  // Untuk menyimpan warna yang digunakan sebelumnya
  String? lastColor;
  
  for (var i = 0; i < jumlahKembangApi; i++) {
    // Pilih warna yang tidak sama dengan warna terakhir
    String color;
    do {
      color = colors[Random().nextInt(colors.length)];
    } while (color == lastColor);

    // Simpan warna terakhir
    lastColor = color;
    
    await firework(i, color, backgroundColors[colors.indexOf(color)]);
  }

  resetConsole();

  animasiAsciiText();
}

Future<void> firework(int seed, String color, String bgColor) async {
  final width = stdout.terminalColumns;
  final height = stdout.terminalLines;

  // Proses peluncuran kembang api (garis lurus ke atas)
  for (var y = height; y > height ~/ 2; y--) {
    setCursorPosition(width ~/ 2, y);
    stdout.write('$color|');
    await Future.delayed(Duration(milliseconds: 50)); // Gunakan await
    setCursorPosition(width ~/ 2, y);
    stdout.write(' ');
  }

  // Tunggu sebentar sebelum menggambar bentuk berlian
  await Future.delayed(Duration(milliseconds: 500));

  // Ledakan berbentuk berlian dengan simbol
  drawFireworkSparks(width ~/ 2, height ~/ 2, color);

  // Tunggu sebentar sebelum mengubah background
  await Future.delayed(Duration(milliseconds: 500));

  // Ubah warna latar belakang terminal sesuai dengan warna ledakan
  setCursorPosition(0, 0); // Kembali ke posisi awal
  stdout.write('$bgColor'); // Terapkan warna background
  stdout.write(' ' * (stdout.terminalColumns * stdout.terminalLines)); // Isi seluruh area dengan warna latar belakang

  // Kembalikan ke warna latar default (reset ANSI)
  await Future.delayed(Duration(milliseconds: 1000)); // Tunggu sejenak untuk melihat efek background
  stdout.write('\x1B[0m');

  clearScreen();
}

// Fungsi untuk menggambar ledakan berbentuk berlian dengan simbol
void drawFireworkSparks(int centerX, int centerY, String color) {
  final fireworkShape = [
    '$color      *      ',
    '$color   *     *   ',
    '$color *   *   *   * ',
    '$color   *     *   ',
    '$color      *      ',
    '$color   *     *   ',
    '$color *   *   *   * ',
    '$color   *     *   ',
    '$color      *      ',
  ];

  for (var i = 0; i < fireworkShape.length; i++) {
    setCursorPosition(centerX - 5, centerY - 4 + i); // Posisikan percikan di tengah
    stdout.write(fireworkShape[i]);
  }
}

void setCursorPosition(int x, int y) {
  stdout.write('\x1B[${y};${x}H');
}

void resetConsole() {
  stdout.write('\x1B[2J\x1B[0;0H');
}

void clearScreen() {
  stdout.write('\x1B[2J');
}



