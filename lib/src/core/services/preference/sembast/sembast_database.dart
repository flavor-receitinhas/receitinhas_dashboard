import 'package:dash_receitas/src/core/services/preference/persistent_database.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/store_sembast_enum.dart';
import 'package:path/path.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:uuid/uuid.dart';

class PersistentDatabaseSembast
    implements PersistentDatabase<StoreSembastEnum> {
  late final Database _db;

  @override
  Future<void> starting() async {
    DatabaseFactory dbFactory = databaseFactoryWeb;
    _db = await dbFactory.openDatabase(join('sembast_v1.db'));
  }

  @override
  Future<void> delete({
    required String id,
    required StoreSembastEnum store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.record(id).delete(_db);
  }

  @override
  Future<Map<String, dynamic>?> get({
    required String id,
    required StoreSembastEnum store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    return await storeref.record(id).get(_db);
  }

  @override
  Future<void> deleteAll({required StoreSembastEnum store}) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.drop(_db);
  }

  @override
  Future<String> create({
    required Map<String, dynamic> objeto,
    required StoreSembastEnum store,
    String? id,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    id ??= const Uuid().v4();
    objeto['id'] = id;
    await storeref.record(id).put(_db, objeto);
    return id;
  }

  @override
  String get version => throw UnimplementedError();

  @override
  Future<void> update({
    required Map<String, dynamic> objeto,
    required StoreSembastEnum store,
    required String id,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    await storeref.record(id).put(_db, objeto);
  }

  @override
  Future<List<Map<String, dynamic>>> list({
    where,
    required StoreSembastEnum store,
  }) async {
    final storeref = StoreRef<String, dynamic>(store.name);
    final result = await storeref.find(_db);
    return result.map((e) => Map<String, dynamic>.from(e.value)).toList();
  }
}
