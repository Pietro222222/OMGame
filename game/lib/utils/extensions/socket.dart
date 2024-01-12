import 'dart:io';

extension GetName on Socket {
  String getName() {
    return '${address.address}:${port}';
  }
}
