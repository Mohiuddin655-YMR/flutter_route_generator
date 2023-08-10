part of 'flutter_route_generator.dart';

typedef RouteBuilder = Widget Function(BuildContext context, Object? data);

abstract class RouteGenerator {
  const RouteGenerator();

  Widget onDefault(BuildContext context, Object? data);

  Widget onError(BuildContext context, Object? data);

  Map<String, RouteBuilder> attach();

  Route<T> _route<T>(String? name, Object? data) {
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

  Route<T> generate<T>(RouteSettings settings) {
    return RouteGeneratorImpl()._route(settings.name, settings.arguments);
  }
}

class RouteGeneratorImpl extends RouteGenerator {
  @override
  Map<String, RouteBuilder> attach() => {};

  @override
  Widget onDefault(BuildContext context, Object? data) => const Scaffold();

  @override
  Widget onError(BuildContext context, Object? data) => const ErrorScreen();
}
