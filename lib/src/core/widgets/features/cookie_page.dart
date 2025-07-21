import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_page_error.dart';
import 'package:flutter/material.dart';

class CookiePage extends StatelessWidget {
  final Widget Function() done;
  final StateManager state;
  final Widget Function()? loading;
  final String error;
  final void Function() errorReload;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  const CookiePage({
    super.key,
    required this.state,
    required this.done,
    required this.error,
    this.loading,
    this.appBar,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    required this.errorReload,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: SafeArea(
        child: bottomNavigationBar ?? const SizedBox.shrink(),
      ),
      body: Builder(
        builder: (context) {
          switch (state) {
            case StateManager.initial:
              return Center(
                child: loading != null
                    ? loading!()
                    : const CircularProgressIndicator(),
              );
            case StateManager.loading:
              return Center(
                child: loading != null
                    ? loading!()
                    : const CircularProgressIndicator(),
              );
            case StateManager.success:
              return done();
            case StateManager.error:
              return CookiePageError(
                errorMessage: error,
                onReload: errorReload,
              );
          }
        },
      ),
    );
  }
}
