import 'dart:developer' as developer;
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class PlantRouterObserver extends AutoRouterObserver {
  static const _logName = 'RouterObserver';

  String _routeName(Route<dynamic>? route) =>
      route?.settings.name ?? '<unnamed>';

  void _log(
    String event, {
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  }) {
    final current = _routeName(route);
    final previous = _routeName(previousRoute);
    developer.log(
      '$event | current: $current | previous: $previous',
      name: _logName,
    );
  }

  @override
  void didPush(Route route, Route<dynamic>? previousRoute) {
    _log('didPush', route: route, previousRoute: previousRoute);
  }

  @override
  void didPop(Route route, Route<dynamic>? previousRoute) {
    _log('didPop', route: route, previousRoute: previousRoute);
  }

  @override
  void didRemove(Route route, Route<dynamic>? previousRoute) {
    _log('didRemove', route: route, previousRoute: previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final oldName = _routeName(oldRoute);
    final newName = _routeName(newRoute);
    developer.log(
      'didReplace | old: $oldName -> new: $newName',
      name: _logName,
    );
  }

  void didInit() {
    developer.log('didInit', name: _logName);
  }

  @override
  void didStartUserGesture(Route route, Route<dynamic>? previousRoute) {
    _log('didStartUserGesture', route: route, previousRoute: previousRoute);
  }

  @override
  void didStopUserGesture() {
    developer.log('didStopUserGesture', name: _logName);
  }
}
