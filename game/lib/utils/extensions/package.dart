import 'dart:convert';
import 'dart:io';

import 'package:game/packages/package.dart';

extension PackageEncoder on Package {
  String encode() {
    return jsonEncode(this);
  }

  void send(Socket socket) {
    socket.write(encode());
  }
}
