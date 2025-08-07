import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/features/auth/presenter/controller/auth_controller.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final ct = di<AuthController>();

  @override
  void initState() {
    super.initState();

    ct.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    ct.removeListener(() => setState(() {}));
    ct.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CookiePage(
      state: StateManager.success,
      error: '',
      errorReload: () {},
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Theme.of(context).brightness == Brightness.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            iconSize: 32,
          ),
        ],
      ),
      done: () {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      Center(
                        child: Image.asset(
                          ImagesEnum.eggHello.path,
                          height: MediaQuery.of(context).size.height * 0.25,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 32),

                      CookieText(
                        text: 'Bem-vindo ao Dash Receitas',
                        typography: CookieTypography.title,
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      CookieText(
                        text: 'Faça login para acessar seu dashboard',
                        typography: CookieTypography.body,
                        textAlign: TextAlign.center,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withValues(alpha: 0.7),
                      ),

                      const SizedBox(height: 32),

                      CookieTextField(
                        controller: ct.emailController,
                        hintText: 'Digite seu email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite seu email';
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return 'Por favor, digite um email válido';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      CookieTextField(
                        controller: ct.passwordController,
                        hintText: 'Digite sua senha',
                        obscureText: ct.showPassword,
                        maxLines: 1,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              ct.showPassword = !ct.showPassword;
                            });
                          },
                          child: Icon(
                            ct.showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite sua senha';
                          }
                          if (value.length < 6) {
                            return 'A senha deve ter pelo menos 6 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      CookieButton(
                        label: 'Entrar',
                        onPressed: ct.state == StateManager.loading
                            ? null
                            : () async {
                                await ct.login(context);
                                if (ct.state == StateManager.success &&
                                    context.mounted) {
                                  context.go(HomePage.route);
                                }
                              },
                        isLoading: ct.state == StateManager.loading,
                        height: 52,
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
