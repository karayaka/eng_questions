import 'package:hive_flutter/adapters.dart';

abstract class BaseDbManager<T extends HiveObject> {
  final String key;
  Box<T?>? _box;

  BaseDbManager(this.key);

  Future<void> init() async {
    registerAdapters();
    _box = await Hive.openBox(key);
  }

  void registerAdapters();

  Future<void> clearAll() async {
    try {
      await _box?.clear();
    } catch (e) {
      throw e;
    }
  }

  Future<int?> addItem(T model) async {
    try {
      _box!.isOpen;
      //id konusuna dönülecek
      //var id = new DateTime.now().millisecondsSinceEpoch;
      return await _box?.add(model);
    } catch (e) {
      throw e;
    }
  }

  Future<void> addItems(List<T> items) async {
    try {
      await _box?.addAll(items);
    } catch (e) {
      throw e;
    }
  }

  Future<void> putItems(List<T> items) async {
    try {
      putItems(items);
    } catch (e) {
      throw e;
    }
  }

  T? getItem(dynamic key) {
    try {
      return _box?.get(key);
    } catch (e) {
      throw e;
    }
  }

  ///quasry parametresi kotrol edilecvek
  List<T?>? getValues(bool Function(T? element) test) {
    try {
      var values = _box?.values.where(test).toList();
      return values;
    } catch (e) {
      throw e;
    }
  }

  T? getFist() {
    try {
      return _box?.values.firstWhere((element) => true, orElse: () => null);
    } catch (e) {
      throw e;
    }
  }

  T? getFistWhere(bool Function(T? element) q) {
    try {
      return _box?.values.firstWhere(q, orElse: () => null);
    } catch (e) {
      throw e;
    }
  }

  Future<int?> putItem(int key, T item) async {
    try {
      await _box?.put(key, item);
      return 1;
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeItem(int key) async {
    try {
      await _box?.delete(key);
    } catch (e) {
      throw e;
    }
  }

  Future<void> removeItems(List<T?> keys) async {
    try {
      await _box?.deleteAll(keys);
    } catch (e) {
      throw e;
    }
  }

  Future<void> closeBox() async {
    try {
      //await _box?.close();
    } catch (e) {
      throw e;
    }
  }
}
