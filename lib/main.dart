import 'package:catex/catex.dart';
import 'package:flutter/material.dart';
import 'package:kalqlus/screens/home_page/home_page.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    final exception = details.exception;
    if (exception is CaTeXException) {
      return ErrorWidget(exception);
    }

    var message = '';
    assert(() {
      message = '${details.exception}\n'
          'See also: https://flutter.dev/docs/testing/errors';
      return true;
    }());

    return ErrorWidget.withDetails(
      message: message,
      error: exception is FlutterError ? exception : null,
    );
  };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KalQlus',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
