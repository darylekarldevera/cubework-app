import 'package:cubework_app_client/utils/serializable/locations.dart';

abstract class ReservedPlace {
  Office? get office;
  DateTimeInfo get startDate;
  DateTimeInfo get endDate;
}

class DateTimeInfo {
  final DateTime? date;
  final String? time;
  final String? meridiem;

  DateTimeInfo({ this.date, this.time, this.meridiem });
}

class ReservedPlaceImpl implements ReservedPlace {
  @override
  Office? office;

  @override
  DateTimeInfo startDate;

  @override
  DateTimeInfo endDate;

  ReservedPlaceImpl({
    required this.office,
    required this.startDate,
    required this.endDate,
  });
}