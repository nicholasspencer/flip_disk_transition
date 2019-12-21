import 'package:bit_array/bit_array.dart';
import 'package:collection/collection.dart';

class Character extends DelegatingIterable {
  final List<ListSet> _matrix;

  const Character(
    List<ListSet> matrix,
  )   : _matrix = matrix,
        super(matrix);

  factory Character.fromSorted(List<List<int>> matrix) {
    return Character(
      matrix
          .map(
            (e) => ListSet.fromSorted(e),
          )
          .toList(),
    );
  }

  factory Character.fromSize({
    int height = 0,
    int width = 0,
    int value = 0,
  }) {
    return Character(
      List.filled(
        height,
        ListSet.fromSorted(
          List.filled(width, value),
        ),
      ),
    );
  }

  static final Character zero = Character.fromSorted(
    [
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 1, 1, 1, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 1, 1, 0],
      [1, 1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 0, 0, 0, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1, 0],
      [0, 0, 1, 1, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0],
    ],
  );

  static final Character colon = Character.fromSorted(
    [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [1, 1, 1],
      [1, 1, 1],
      [1, 1, 1],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
    ],
  );

  Character operator +(Character other) {
    assert(length == other.length);

    final joined = IterableZip([_matrix, other._matrix]).map((zipper) {
      return ListSet.fromSorted(
        zipper[0].asIntIterable().toList() + zipper[1].asIntIterable().toList(),
      );
    }).toList();

    return Character(
      joined,
    );
  }
}
