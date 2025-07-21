import 'package:dash_receitas/src/core/services/preference/sembast/sembast_database.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/store_sembast_enum.dart';
import 'package:dash_receitas/src/core/services/preference/user_preference/key_preference.dart';
import 'package:dash_receitas/src/core/services/preference/user_preference/user_preference_entity.dart';

class Preference {
  final PersistentDatabaseSembast _persistentDatabaseSembast;

  Preference(this._persistentDatabaseSembast);

  Future<T> get<T>({required KeyPreferences keyPreferences}) async {
    final result = await _persistentDatabaseSembast.get(
      id: keyPreferences.name,
      store: StoreSembastEnum.userPreference,
    );
    if (result == null) {
      return keyPreferences.defaultValue;
    }
    final userPreference = UserPreferenceEntity.fromJson(result);
    return userPreference.value ?? keyPreferences.defaultValue;
  }

  Future<void> put<T>({
    required T value,
    required KeyPreferences keyPreferences,
  }) async {
    await _persistentDatabaseSembast.update(
      id: keyPreferences.name,
      objeto: UserPreferenceEntity(
        value: value,
        id: keyPreferences.name,
      ).toJson(),
      store: StoreSembastEnum.userPreference,
    );
  }

  Future<void> delete({required KeyPreferences keyPreferences}) async {
    await _persistentDatabaseSembast.delete(
      id: keyPreferences.name,
      store: StoreSembastEnum.userPreference,
    );
  }
}
