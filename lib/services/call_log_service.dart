import 'package:hive/hive.dart';

class CallLogService {
  final _boxName = 'callLogs';

  Future<void> addLog(String summary) async {
    final box = await Hive.openBox(_boxName);
    await box.add({'summary': summary, 'timestamp': DateTime.now().toString()});
  }

  Future<List> getLogs() async {
    final box = await Hive.openBox(_boxName);
    return box.values.toList();
  }
}
