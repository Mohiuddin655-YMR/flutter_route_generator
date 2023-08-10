part of 'flutter_route_generator.dart';

typedef RouteBuilder = Widget Function(BuildContext context, Object? data);

abstract class RouteGenerator {
  const RouteGenerator();

  Map<String, RouteBuilder> attach();

  Widget onDefault(BuildContext context, Object? data);

  Widget onError(BuildContext context, Object? data) => const ErrorScreen();

  Route<T> generate<T>(RouteSettings settings) {
    var name = settings.name;
    var data = settings.arguments;
    var mRoutes = attach();
    var isValidRoute = mRoutes.isNotEmpty;
    if (isValidRoute) {
      var route = mRoutes[name];
      if (route != null) {
        return MaterialPageRoute<T>(
          builder: (context) => route(context, data),
        );
      } else {
        return MaterialPageRoute<T>(
          builder: (context) => onError(context, data),
        );
      }
    } else {
      return MaterialPageRoute<T>(
        builder: (context) => onDefault(context, data),
      );
    }
  }
}
