import 'dart:io';

import 'package:path/path.dart';

/// This script takes a directory and deletes all files that are not inside
/// the `.git` directory.
///
/// This gives us a clean slate to work with when we want to update existing
/// git repository with new codelessly code.
///
/// Usage: dart bin/remover.dart <git-repo-dir>
void main(List<String> args) {
  if (args.length != 1) {
    stderr.writeln('Required arguments not provided.');
    stderr.writeln('Usage: dart bin/remover.dart <git-repo-dir>');
    exit(1);
  }

  final Directory gitDirectory = Directory(args[0]);

  if (!gitDirectory.existsSync()) {
    stderr.writeln('Specified git directory does not exist.');
    exit(1);
  }

  // Get all required params from command line
  final List<FileSystemEntity> files = gitDirectory.listSync();
  stdout.writeln('Found files and directories: ${files.length}');
  // Exclude .git directory
  files.removeWhere((entity) {
    return entity is Directory && basename(entity.path) == '.git';
  });

  // print top level files and directories
  stdout.writeln('Files & Directories to be deleted (${files.length}):');
  for (final file in files) {
    print(' - ${file.path}');
  }

  print('Deleting files...');
  for (final file in files) {
    stdout.write('Deleting ${file.path}...');
    if (file is Directory) {
      file.deleteSync(recursive: true);
    } else {
      file.deleteSync();
    }
    stdout.writeln(' Done!');
  }

  print('Done!');
}
