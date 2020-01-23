import 'disc_character.dart';

extension DiscString on String {
  List<DiscCharacter> toDiscCharacters() {
    return codeUnits.map((unit) {
      return DiscCharacterExtension.fromCharCode(unit);
    });
  }
}
