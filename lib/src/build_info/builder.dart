library builder;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:build/build.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

Builder buildInfo([BuilderOptions options]) => _InfoBuilder();

class _InfoBuilder implements Builder {
  @override
  Future build(BuildStep buildStep) async {
    final pubspecText = File('pubspec.yaml').readAsStringSync();

    final pubspec = Pubspec.parse(pubspecText);

    String gitVersion = (await Process.run(
            'git', ['describe', '--long', '--dirty', '--tags', '--always'],
            stdoutEncoding: utf8))
        .stdout
        .toString()
        .trim();

    buildStep.writeAsString(
        AssetId(
            buildStep.inputId.package, 'lib/src/build_info/build_info.g.dart'),
        '''
const packageVersion = '${pubspec.version}';
const gitVersion = '${gitVersion}';
''');
  }

  @override
  final buildExtensions = const {
    r'$lib$': ['src/build_info/build_info.g.dart']
  };
}
