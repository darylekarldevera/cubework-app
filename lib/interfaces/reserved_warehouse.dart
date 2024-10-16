

import 'package:cubework_app_client/models/warehouse.dart';

abstract class ReservedWarehouse {
  Warehouse get warehouse;
  DateTimeInfo get startDate;
  DateTimeInfo get endDate;
}

class DateTimeInfo {
  final DateTime? date;
  final String? time;
  final String? meridiem;

  DateTimeInfo({ this.date, this.time, this.meridiem });
}

class ReservedWarehouseImpl implements ReservedWarehouse {
  @override
  Warehouse warehouse;

  @override
  DateTimeInfo startDate;

  @override
  DateTimeInfo endDate;

  ReservedWarehouseImpl({
    required this.warehouse,
    required this.startDate,
    required this.endDate,
  });
}