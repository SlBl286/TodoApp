import '/resources/pages/add_task_page.dart';
import '/resources/pages/splash_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/*
|--------------------------------------------------------------------------
| App Router
|
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "flutter pub run nylo_framework:main make:page profile_page"
| Learn more https://nylo.dev/docs/4.x/router
|--------------------------------------------------------------------------
*/

appRouter() => nyRoutes((router) {
      router.route("/", (context) => SplashPage());

      // Add your routes here

      // router.route("/new-page", (context) => NewPage(), transition: PageTransitionType.fade);

      router.route(HomePage().route, (context) => HomePage());

      router.route(AddTaskPage().route, (context) => AddTaskPage());
    });
