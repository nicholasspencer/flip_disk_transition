import 'dart:math';

import 'package:flipdisc/src/index_path.dart';
import 'package:flutter/material.dart';

import 'character.dart';
import 'flip_disk.dart';

class FlipDiskBoard extends StatefulWidget {
  @override
  _FlipDiskBoardState createState() => _FlipDiskBoardState();
}

class _FlipDiskBoardState extends State<FlipDiskBoard> {
  Character data = Character.one;
  final margin = .5;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    data = Character.zero;
    data = Character.fromSize(height: 21, width: 2, value: 0) +
        Character.one +
        Character.fromSize(height: 21, width: 2, value: 0) +
        Character.three +
        Character.fromSize(height: 21, width: 2, value: 0) +
        Character.three +
        Character.fromSize(height: 21, width: 2, value: 0) +
        Character.seven +
        Character.fromSize(height: 21, width: 2, value: 0);

    final horizontalCount = data.row(0).length;

    print(horizontalCount);

    return Container(
      color: theme.backgroundColor,
      child: Align(
        child: AspectRatio(
          aspectRatio: 5.0 / 3.0,
          child: Container(
            decoration: BoxDecoration(
                color: theme.backgroundColor, boxShadow: [BoxShadow()]),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.minWidth;
                final size = (width - ((margin * 2) * horizontalCount)) /
                    horizontalCount;
                print(size);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int row = 0; row < data.length; row++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int column = 0;
                              column < data.row(row).length;
                              column++)
                            FlipDisk(
                              onColor: theme.primaryColorLight,
                              offColor: theme.primaryColorDark,
                              size: Size.square(size),
                              margin: EdgeInsets.all(margin),
                              isOn:
                                  data[IndexPath(column: column, row: row)] == 0
                                      ? false
                                      : true,
                              onTap: () {
                                final indexPath = IndexPath(
                                  column: column,
                                  row: row,
                                );
                                final isOn = data[indexPath] == 1;
                                setState(() {
                                  data[indexPath] = isOn ? 0 : 1;
                                });
                              },
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
