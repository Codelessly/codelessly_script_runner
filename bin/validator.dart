import 'dart:io';

void validateParams(Map<String, dynamic> params) {
  if (!params.containsKey('authToken')) {
    stderr.writeln('authToken is missing from parameters.');
    exit(1);
  }
  if (params['authToken'] is! String) {
    stderr.writeln('authToken is invalid.');
    exit(1);
  }

  if (!params.containsKey('slug')) {
    stderr.writeln('slug is missing from parameters.');
    exit(1);
  }

  if (params['slug'] is! String) {
    stderr.writeln('slug is invalid.');
    exit(1);
  }
}