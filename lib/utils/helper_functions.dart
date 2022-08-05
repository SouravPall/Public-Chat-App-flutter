import 'package:intl/intl.dart';

String getFormattedDate(DateTime dateTime, {String format = 'dd/MM/yyyy HH:mm'}) =>
    DateFormat(format).format(dateTime);