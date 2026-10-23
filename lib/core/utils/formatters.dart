import 'package:intl/intl.dart';

String formatPrice(num value) =>
    NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(value);

String formatDate(DateTime d) => DateFormat('MMM d, yyyy').format(d);