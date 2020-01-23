import 'dart:math';

import 'package:flipdisc/src/disc_matrix.dart';
import 'package:flipdisc/src/index_path.dart';
import 'package:flutter/material.dart';

import 'disc_matrix.dart';
import 'flip_disc.dart';

class FlipDiscBoard extends StatefulWidget {
  final DiscMatrix matrix;

  FlipDiscBoard({@required this.matrix});
  @override
  _FlipDiscBoardState createState() => _FlipDiscBoardState();
}

class _FlipDiscBoardState extends State<FlipDiscBoard> {
  final margin = .5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maxDotCount = max(widget.matrix.rows, widget.matrix.columns);

    return Container(
      color: theme.backgroundColor,
      child: Align(
        child: AspectRatio(
          aspectRatio: 5.0 / 3.0,
          child: Container(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              boxShadow: [BoxShadow()],
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final boundingLength =
                    max(constraints.minWidth, constraints.minHeight);
                final size = (boundingLength - ((margin * 2) * maxDotCount)) /
                    maxDotCount;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int row = 0; row < widget.matrix.rows; row++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int column = 0;
                              column < widget.matrix.columns;
                              column++)
                            FlipDisc(
                              onColor: theme.primaryColorLight,
                              offColor: theme.primaryColorDark,
                              size: Size.square(size),
                              margin: EdgeInsets.all(margin),
                              isOn: widget.matrix[IndexPath(
                                        column: column,
                                        row: row,
                                      )] ==
                                      0
                                  ? false
                                  : true,
                            ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class FlipBoardMatrix {
  final BoxConstraints boardConstraints;
  final Size diskSize;

  const FlipBoardMatrix({
    this.boardConstraints,
    this.diskSize,
  });
}
