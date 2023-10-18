import 'package:hive_flutter/hive_flutter.dart';

//generic class for Hive storage
class OfflineDatabase {
  final String dbName;

  OfflineDatabase({required this.dbName});

  Future addData<E>(E data, String? databaseName) async {
    await Hive.box<E>(databaseName ?? dbName).add(data);
  }

  Future<List<E>> retrieveData<E>(String? databaseName) async {
    final dataList = await Hive.box<E>(databaseName ?? dbName);

    if (dataList.isNotEmpty) {
      return dataList.values.toList();
    }
    return [];
  }

  Future updateData<E>(E data, int index) async {
    await Hive.box<E>(dbName).putAt(index, data);
  }

  Future deleteDatabase<E>({String? databaseName}) async {
    await Hive.box<E>(databaseName ?? dbName)
        .deleteAll(Hive.box<E>(databaseName ?? dbName).keys);
  }
}
