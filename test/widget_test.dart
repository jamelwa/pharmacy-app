import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:simple_app/main.dart';

void main() {
  testWidgets('renders Apotek SehatPlus home mockup', (tester) async {
    await tester.pumpWidget(const ApotekSehatPlusApp());
    await tester.pumpAndSettle();

    expect(find.text('Halo, Rani'), findsOneWidget);
    expect(find.text('Unggah Resep'), findsOneWidget);
    expect(find.text('Katalog\nObat'), findsOneWidget);
  });

  testWidgets('bottom navigation opens other pages', (tester) async {
    await tester.pumpWidget(const ApotekSehatPlusApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kategori'));
    await tester.pumpAndSettle();
    expect(find.text('Produk populer'), findsOneWidget);

    await tester.tap(find.text('Resep').last);
    await tester.pumpAndSettle();
    expect(find.text('Upload resep dokter'), findsOneWidget);

    await tester.tap(find.text('Pesanan'));
    await tester.pumpAndSettle();
    expect(find.text('ORD-8891 sedang dikirim'), findsOneWidget);

    await tester.tap(find.text('Akun'));
    await tester.pumpAndSettle();
    expect(find.text('Rani Putri'), findsOneWidget);
  });

  testWidgets('feature cards open detail page', (tester) async {
    await tester.pumpWidget(const ApotekSehatPlusApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Unggah Resep'));
    await tester.pumpAndSettle();

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Upload Resep'), findsWidgets);
  });
}
