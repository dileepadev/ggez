import 'package:intl/intl.dart';

class DateTimeChecker {
  String dateNow = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String timeNow = DateFormat('KK:mm:ss a').format(DateTime.now());
  String dateTimeNow = DateFormat.yMMMMEEEEd().add_jms().format(DateTime.now());
}
