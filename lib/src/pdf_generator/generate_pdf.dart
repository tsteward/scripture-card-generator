import 'dart:math';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'verse.dart';
import 'verse-table.dart';

const _pdfSize = PdfPageFormat.letter;

List<int> generatePdf(List<Verse> vereses) {
  final Document pdf = Document();

  var chunked = List<List<Verse>>();

  for (int i = 0; i < vereses.length; i += 12) {
    chunked.add(vereses.sublist(i, min(i + 12, vereses.length)));
  }

  for (var chunk in chunked) {
    pdf.addPage(
      Page(
        pageFormat: _pdfSize.landscape.copyWith(
          marginTop: 36,
          marginBottom: 36,
          marginLeft: 36,
          marginRight: 36,
        ),
        build: (Context context) => VerseTable(verses: chunk),
      ),
    );
  }

  return pdf.save();
}
