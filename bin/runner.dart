import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mustachex/mustachex.dart';
import 'package:path/path.dart';

Future<void> replaceAllMoustache(
    Directory directory,
    Map<String, dynamic> data,
    ) async {
  final Stopwatch stopwatch = Stopwatch()..start();
  stdout.writeln('Replacing all moustaches in ${directory.path}');
  final processor = MustachexProcessor(initialVariables: data);

  final List<FileSystemEntity> files =
  await directory.list(recursive: true).toList();

  final length = files.length;
  stdout.writeln('About to process [$length] files.');
  for (final (i, file) in files.indexed) {
    if (file is! File) continue;
    final absolutePath = file.absolute.path;
    final ext = extension(file.path);
    if (ext.isEmpty) continue;
    if (ext.endsWith('js')) continue;
    if (absolutePath.contains('.git')) continue;
    if (absolutePath.contains('canvaskit')) continue;

    final Uint8List bytes = await file.readAsBytes();
    try {
      stdout.write('Processing [${i + 1} / $length] ${file.path}...');
      final String content = utf8.decode(bytes);
      final String rendered = await processor.process(content);

      await file.writeAsString(rendered);
      stdout.writeln(' Done!');
    } catch (e) {
      stdout.writeln(' Not UTF8, skipped!');
      continue;
    }
  }

  stdout.writeln('Done replacing all moustaches in ${directory.path}');

  stopwatch.stop();
  stdout.writeln('Took ${stopwatch.elapsed.inSeconds} seconds.');
}