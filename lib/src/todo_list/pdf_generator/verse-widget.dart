import 'package:pdf/widgets.dart';

import '../verse.dart';

class VerseWidget extends StatelessWidget {
  final Verse verse;

  VerseWidget(this.verse);

  @override
  Widget build(Context context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(width: 198, height: 126),
      child: Padding(
        padding: EdgeInsets.all(3.6),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    verse.title,
                    style: TextStyle(font: Font.helveticaBold(), fontSize: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    verse.reference,
                    style: TextStyle(font: Font.helvetica(), fontSize: 9),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    '      ${verse.text}',
                    style: TextStyle(font: Font.helvetica(), fontSize: 9),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(verse.reference,
                      style: TextStyle(font: Font.helvetica(), fontSize: 9),
                      textAlign: TextAlign.right),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                verse.version,
                style: TextStyle(font: Font.helvetica(), fontSize: 9),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                verse.subtext,
                style: TextStyle(font: Font.helveticaOblique(), fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
