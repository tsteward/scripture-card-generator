import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:esv_api/esv_api.dart';

import 'todo_list_service.dart';
import 'verse.dart';
import 'pdf_generator/generate-pdf.dart';

@Component(
  selector: 'todo-list',
  styleUrls: ['todo_list_component.css'],
  templateUrl: 'todo_list_component.html',
  directives: [
    MaterialCheckboxComponent,
    MaterialFabComponent,
    MaterialIconComponent,
    MaterialButtonComponent,
    materialInputDirectives,
    NgFor,
    NgIf,
  ],
  providers: [ClassProvider(TodoListService)],
)
class TodoListComponent implements OnInit {
  final TodoListService todoListService;

  List<Verse> items = [];
  String newReference = '';
  String newTitle = '';
  String newSubtext = '';

  TodoListComponent(this.todoListService);

  @override
  Future<Null> ngOnInit() async {
    items = await todoListService.getTodoList();
  }

  void add() {
    items.add(
        Verse(reference: newReference, title: newTitle, subtext: newSubtext));
    newReference = '';
    newTitle = '';
    newSubtext = '';
  }

  Verse remove(int index) => items.removeAt(index);

  pdf() async {
    var esvApi = ESVAPI('Insert API Key');

    var requests = Map<String, Future<String>>();
    for (var line in items) {
      if (!requests.containsKey(line.reference)) {
        requests[line.reference] = callApi(esvApi, line.reference);
      }
    }

    var verses = List<Verse>();
    for (var line in items) {
      verses.add(Verse(
        text: await requests[line.reference],
        version: 'ESV',
        reference: line.reference,
        subtext: line.subtext,
        title: line.title,
      ));
    }

    var pdf = generatePdf(verses);
    var blob = new Blob([latin1.decode(pdf)], 'application/pdf');
    var url = Url.createObjectUrlFromBlob(blob);
    window.open(url, "_self");
  }
}

Future<String> callApi(ESVAPI esvApi, String verse) async {
  var validResponse = false;
  PassageTextResponse response;
  while (!validResponse) {
    response = await esvApi.getPassageText(
      verse,
      include_passage_references: false,
      include_verse_numbers: false,
      include_first_verse_numbers: false,
      include_footnotes: false,
      include_footnote_body: false,
      include_headings: false,
      include_short_copyright: false,
      include_copyright: false,
      include_passage_horizontal_lines: false,
      include_heading_horizontal_lines: false,
      horizontal_line_length: 0,
      include_selahs: false,
      indent_using: '',
      indent_paragraphs: 0,
      indent_poetry: false,
      indent_poetry_lines: 0,
      indent_declares: 0,
      indent_psalm_doxology: 0,
      line_length: 0,
    );
    if (response.detail == null) {
      validResponse = true;
    } else {
      print(response.detail);
      var match =
          RegExp(r"Request was throttled\. Try again in (\d*) seconds\.")
              .firstMatch(response.detail);
      if (match == null) {
        validResponse = true;
      } else {
        await Future.delayed(Duration(seconds: int.parse(match.group(1))));
      }
    }
  }

  return capitalizeFirst(response.passages.join())
      .replaceAll(RegExp(r"[“”]"), '"')
      .replaceAll(RegExp(r"[‘’]"), '\'')
      .replaceAll(RegExp(r"[—]"), '-')
      .replaceAll(RegExp(r"[\s]+"), ' ')
      .trim();
}

String capitalizeFirst(String s) => s[0].toUpperCase() + s.substring(1);
