import 'package:intl/intl.dart';

String formatDate(DateTime value) {
  var outputFormat = DateFormat('MM/dd/yyyy');
  return outputFormat.format(value);
}
