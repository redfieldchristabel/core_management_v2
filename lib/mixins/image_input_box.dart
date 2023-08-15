import 'dart:io';

///implement this mixin within your class
///so it can be generic type of [ImageInputBoxInstance]
///class,
mixin ImageInputBoxMixin {
  ///get [File] instance from any source including network or such
  Future<File> get file;
}
