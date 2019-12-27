class IndexPath {
  final int column;
  final int row;

  const IndexPath({
    this.column = 0,
    this.row = 0,
  })  : assert(column != null),
        assert(row != null);
}
