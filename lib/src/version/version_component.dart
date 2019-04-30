import 'dart:async';

import 'package:angular/angular.dart';

import '../../build_info.dart' as build_info;

@Component(
  selector: 'version',
  templateUrl: 'version_component.html',
)
class VersionComponent implements OnInit {
  String packageVersion = '';
  String gitVersion = '';

  @override
  Future<Null> ngOnInit() async {
    packageVersion = build_info.packageVersion;
    gitVersion = build_info.gitVersion;
  }
}
