// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'word.g.dart';

@collection
class Word {
    Id id = Isar.autoIncrement;
    late String englishWord;
    late String turkishWord;
    late String wordType;
    String? story;
    List<int>? imagesBytes;
    bool isLearned=false;
    Word({
    required this.englishWord,
    required this.turkishWord,
    required this.wordType,
    this.story,
    this.imagesBytes,
});
    DateTime createdAt = DateTime.now();

  @override
  String toString() {
    return 'Word(id: $id, englishWord: $englishWord, turkishWord: $turkishWord, wordType: $wordType, story: $story, imagesBytes: $imagesBytes, isLearned=false: $isLearned=false)';
  }
}
