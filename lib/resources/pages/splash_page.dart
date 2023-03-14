import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/config/theme.dart';
import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';
import '/app/controllers/splash_controller.dart';

class SplashPage extends NyStatefulWidget {
  final SplashController controller = SplashController();

  SplashPage({Key? key}) : super(key: key, routeName: "/");

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends NyState<SplashPage> {
  @override
  init() async {}
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ThemeColor.get(context).isDarkTheme) {
        NyTheme.set(context, id: ThemeConfig.dark().id);
      }
      routeTo(HomePage().route, navigationType: NavigationType.pushReplace);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container()),
    );
  }
}
