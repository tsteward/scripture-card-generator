import 'dart:async';

import 'package:angular/core.dart';

import '../../pdf_generator.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class TodoListService {
  List<Verse> mockTodoList = <Verse>[];

  Future<List<Verse>> getTodoList() async => mockTodoList;
}
