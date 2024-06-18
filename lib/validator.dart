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

  final slug = params['slug'];
  final layoutId = params['layoutID'];

  // Needs either a slug or a layout id.
  if (slug == null && layoutId == null) {
    stderr.writeln('slug or layoutID is required.');
    exit(1);
  }

  // If slug is provided, it must be a string.
  if (slug != null && slug is! String) {
    stderr.writeln('slug is invalid.');
    exit(1);
  }

  // If layoutID is provided, it must be a string.
  if (layoutId != null && layoutId is! String) {
    stderr.writeln('layoutID is invalid.');
    exit(1);
  }
}
