import 'package:meta/meta.dart';

@immutable
class Verse {
  final String reference;
  final String text;
  final String title;
  final String version;
  final String subtext;

  Verse({
    @required this.reference,
    @required this.text,
    this.title = '',
    this.version = '',
    this.subtext = '',
  });
}
