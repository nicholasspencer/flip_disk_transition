import 'package:flipdisc/src/disc_matrix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/flip_disc_board.dart';
import 'src/disc_matrix.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.landscapeRight],
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final matrix = DiscMatrixList([
    DiscMatrix.u48,
    DiscMatrix.u48,
    DiscMatrix.u48,
    DiscMatrix.u48,
  ]).join();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      home: FlipDiscBoard(matrix: matrix),
    );
  }
}
