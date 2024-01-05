import 'dart:convert';
import 'dart:io';

import 'runner.dart';
import 'validator.dart';

const String defaultProjectName = 'My Project';
const String defaultProjectDescription = 'A new codelessly starter project';

void main(List<String> args) async {
  if (args.length != 2) {
    stderr.writeln('Required arguments not provided.');
    stderr.writeln('Usage: dart bin/main.dart <template-dir> <config_json>');
    exit(1);
  }

  final Directory brickDirectory = Directory(args[0]);

  if (!brickDirectory.existsSync()) {
    stderr.writeln('Template directory does not exist.');
    exit(1);
  }

  // Get all required params from command line
  final Map<String, dynamic> params = jsonDecode(args[2]);

  validateParams(params);

  final String slug = params['slug']!;
  final String codelesslyAuthToken = params['authToken']!;
  final String layoutID = params['layoutID'] ?? '';
  final String name = params['name'] ?? defaultProjectName;
  final String description = params['description'] ?? defaultProjectDescription;

  stdout.write('Replacing all moustaches...');
  await replaceAllMoustache(
    brickDirectory,
    {
      'name': name,
      'description': description,
      'authToken': codelesslyAuthToken,
      'slug': slug,
      'layoutID': layoutID,
    },
  );
  stdout.write('Done!');
}
