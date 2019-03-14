import 'package:meta/meta.dart';
import 'package:pdf/widgets.dart';

import 'verse-widget.dart';
import '../verse.dart';

class VerseTable extends StatelessWidget {
  final List<Verse> verses;
  final int columns;

  VerseTable({@required this.verses, this.columns = 3});

  @override
  Widget build(Context context) {
    int col = 0;
    List<TableRow> rows = [];
    List<Widget> rowItems = [];
    for (var verse in verses) {
      if (col >= columns) {
        rows.add(TableRow(children: rowItems));
        rowItems = [];
        col = 0;
      }

      rowItems.add(VerseWidget(verse));
      col++;
    }
    rows.add(TableRow(children: rowItems));
    rowItems = [];

    return Table(
        tableWidth: TableWidth.min,
        border: TableBorder(
          left: true,
          top: true,
          right: true,
          bottom: true,
          horizontalInside: true,
          verticalInside: true,
        ),
        children: rows);
  }
}
