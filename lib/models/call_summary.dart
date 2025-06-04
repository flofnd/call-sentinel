import 'package:hive/hive.dart';

part 'call_summary.g.dart';

@HiveType(typeId: 0)
class CallSummary extends HiveObject {
  @HiveField(0)
  String caller;

  @HiveField(1)
  String summary;

  @HiveField(2)
  DateTime timestamp;

  CallSummary({
    required this.caller,
    required this.summary,
    required this.timestamp,
  });
}
