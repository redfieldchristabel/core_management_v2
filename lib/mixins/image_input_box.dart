import 'dart:io';

class ImageInputBoxBase {}

///implement this mixin within your class
///so it can be generic type of [ImageInputBoxInstance]
///class,
abstract class ImageInputBoxNetwork extends ImageInputBoxBase {
  ///get [File] instance from the network
  Future<Uri> get uri;
}

///implement this mixin within your class
///so it can be generic type of [ImageInputBoxInstance]
///class,
abstract class ImageInputBoxFile extends ImageInputBoxBase {
  ///get [File] instance from the network
  Future<File> get file;
}
