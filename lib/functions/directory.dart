// ignore_for_file: avoid_slow_async_io, public_member_api_docs

import 'dart:io';

void getDirectory(String myPath) {
  FileSystemEntity.isDirectory(myPath).then((isDir) {
    if (isDir) {
      // ignore: avoid_print
      print('$myPath is a directory');
    } else {
      // ignore: avoid_print
      print('$myPath is not a directory');
    }
  });
}
