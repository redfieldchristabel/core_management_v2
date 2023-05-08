// extension SimpleListTileString<T extends SimpleListTileMixin<T>> on String {}

import 'package:core_management_v2/mixins/simple_list_tile_mixin.dart';

/// class to represent SimpleListTile String that have extend simpleListTile Mixin
/// make sure to use this wrapper if the simple list tile doesnt need to perform any
/// comparable logic like select or else.
/// usually use for [String] or [Enum] only
class SimpleListTileWrapper<T>
    with SimpleListTileMixin<SimpleListTileWrapper<T>> {
  final T value;

  SimpleListTileWrapper(this.value);
  @override
  String get id => value.hashCode.toString();

  @override
  // TODO: implement name
  String get name => value.toString();
}

class SimpleListTileString with SimpleListTileMixin<SimpleListTileString> {
  final String value;

  SimpleListTileString(this.value);
  @override
  // TODO: implement id
  String get id => value;

  @override
  // TODO: implement name
  String get name => value;
}
