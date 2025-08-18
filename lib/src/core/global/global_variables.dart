import 'package:dash_receitas/src/features/auth/domain/entities/user_entity.dart';
import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.instance;

class Global {
  static const String dnsApi = 'https://api.codeventura.com.br';
  static String token = '';
  static UserEntity? user;

  static bool isAdmin = false;
  static Roles role = Roles.common;

  static const imageRecipeDefault =
      'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?q=80&w=2574&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
}
