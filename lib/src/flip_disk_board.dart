import 'package:flutter/material.dart';

import 'character.dart';
import 'flip_disk.dart';

class FlipDiskBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var zero = Character.fromSize(height: 21, width: 2) +
        Character.zero +
        Character.fromSize(height: 21, width: 2) +
        Character.zero +
        Character.fromSize(height: 21, width: 2) +
        Character.colon +
        Character.fromSize(height: 21, width: 2) +
        Character.zero +
        Character.fromSize(height: 21, width: 2) +
        Character.zero +
        Character.fromSize(height: 21, width: 2);

    return Container(
      color: theme.backgroundColor,
      child: Align(
        child: AspectRatio(
          aspectRatio: 500.0 / 300.0,
          child: Container(
            decoration: BoxDecoration(
                color: theme.backgroundColor, boxShadow: [BoxShadow()]),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (var row in zero)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (var column in row.asIntIterable())
                            FlipDisk(
                              onColor: theme.primaryColorLight,
                              offColor: theme.primaryColorDark,
                              size: const Size.square(11),
                              margin: EdgeInsets.all(.5),
                              isOn: column == 0 ? false : true,
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
