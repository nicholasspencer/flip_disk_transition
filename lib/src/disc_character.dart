import 'disc_matrix.dart';

enum DiscCharacter {
  /// 0
  u48,

  /// 1
  u49,

  /// 2
  u50,

  /// 3
  u51,

  /// 4
  u52,

  /// 5
  u53,

  /// 6
  u54,

  /// 7
  u55,

  /// 8
  u56,

  /// 9
  u57,

  /// colon
  u58,
}

extension DiscCharacterExtension on DiscCharacter {
  static DiscCharacter fromCharCode(int code) {
    switch (code) {
      case 48:
        return DiscCharacter.u48;
      case 49:
        return DiscCharacter.u49;
      case 50:
        return DiscCharacter.u50;
      case 51:
        return DiscCharacter.u51;
      case 52:
        return DiscCharacter.u52;
      case 53:
        return DiscCharacter.u53;
      case 54:
        return DiscCharacter.u54;
      case 55:
        return DiscCharacter.u55;
      case 56:
        return DiscCharacter.u56;
      case 57:
        return DiscCharacter.u57;
      case 58:
        return DiscCharacter.u58;
      default:
        throw 'Decoding error';
    }
  }

  DiscMatrix asCharacterMatrix() {
    switch (this) {
      case DiscCharacter.u48:
        return DiscMatrix.u48;
      case DiscCharacter.u49:
        return DiscMatrix.u49;
      case DiscCharacter.u50:
        return DiscMatrix.u50;
      case DiscCharacter.u51:
        return DiscMatrix.u51;
      case DiscCharacter.u52:
        return DiscMatrix.u52;
      case DiscCharacter.u53:
        return DiscMatrix.u53;
      case DiscCharacter.u54:
        return DiscMatrix.u54;
      case DiscCharacter.u55:
        return DiscMatrix.u55;
      case DiscCharacter.u56:
        return DiscMatrix.u56;
      case DiscCharacter.u57:
        return DiscMatrix.u57;
      case DiscCharacter.u58:
        return DiscMatrix.u58;
      default:
        throw 'Encoding error';
    }
  }
}
