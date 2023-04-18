import 'package:intl/intl.dart';

class FormatData {
  getDataFormat(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
