import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:getting_started_flutter/main.dart';

void main() {
  testWidgets('beranda menampilkan 3 card katalog', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Card), findsNWidgets(3));
    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.text('Kopi Susu Gula Aren'), findsOneWidget);
  });

  testWidgets('tap card membuka detail lalu kembali ke beranda',
      (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Kopi Susu Gula Aren'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Detail Katalog'), findsOneWidget);
    expect(find.text('Deskripsi'), findsOneWidget);
    expect(find.text('Rp 22.000'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Waktu melihat detail: 2 detik'), findsOneWidget);

    await tester.tap(find.text('Tandai Favorit'));
    await tester.pump();
    expect(find.text('Favorit Ditandai'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Katalog Produk'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
  });
}
