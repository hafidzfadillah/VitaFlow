import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vitaflow/ui/home/theme.dart';

class ProductPrice extends StatelessWidget {
  final double price;

  const ProductPrice({Key? key, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Membuat instance NumberFormat
    final numberFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');

    return Text(
      // Memformat harga dengan NumberFormat
      numberFormat.format(price),
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: subheaderSize,
      ),
    );
  }
}
