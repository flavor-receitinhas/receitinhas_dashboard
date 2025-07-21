import 'package:api_manager/api/api_manager.dart';
import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/services/api/api_recipes.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/sembast_database.dart';
import 'package:dash_receitas/src/core/services/preference/user_preference/preference_service.dart';
import 'package:dash_receitas/src/core/themes/theme.dart';
import 'package:dio/dio.dart';

class Inject {
  static void inicialize() {
    //Persistente
    di.registerLazySingleton(() => PersistentDatabaseSembast());

    //Preference
    di.registerFactory<Preference>(() => Preference(di()));

    //Themas
    di.registerLazySingleton(() => ThemeService(di()));

    //Api
    di.registerFactory<Dio>(() => Dio());
    di.registerFactory<ApiManager>(() => ApiManager());
    di.registerFactory(() => ApiRecipes(di()));
  }
}
