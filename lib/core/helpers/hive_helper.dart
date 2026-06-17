import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static const String _boxName = 'chatBox';
  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  Future<void> saveData({required String key, required dynamic value}) async {
    await _box.put(key, value);
  }

  dynamic getData({required String key}) {
    return _box.get(key);
  }

  Future<void> removeData({required String key}) async {
    await _box.delete(key);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}