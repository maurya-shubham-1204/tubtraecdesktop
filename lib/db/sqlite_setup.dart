import 'dart:ffi';
import 'dart:io';

import 'package:sqlite3/open.dart';

/// Linux often ships only `libsqlite3.so.0` (runtime) without the
/// unversioned `libsqlite3.so` symlink (dev package). Point sqlite3/drift
/// at the versioned library so offline DB can open.
void setupSqliteOpen() {
  if (!Platform.isLinux) return;

  open.overrideFor(OperatingSystem.linux, () {
    final candidates = <String>[
      'libsqlite3.so.0',
      'libsqlite3.so',
      '/usr/lib/x86_64-linux-gnu/libsqlite3.so.0',
      '/usr/lib/libsqlite3.so.0',
    ];

    Object? lastError;
    for (final name in candidates) {
      try {
        return DynamicLibrary.open(name);
      } catch (e) {
        lastError = e;
      }
    }
    throw StateError(
      'Could not load SQLite. Tried: ${candidates.join(', ')}. Last error: $lastError',
    );
  });
}
