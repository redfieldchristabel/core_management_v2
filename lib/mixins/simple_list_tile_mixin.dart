/// mixin to be used if want this model can be use in simple list tile
mixin SimpleListTileMixin<T extends SimpleListTileMixin<T>> {
  /// a getter method that will be use by [SimpleListTile] widget
  /// to measure the selected element within this Widget,
  /// usually this getter already exist with a normal data modal class
  /// this is just a unique value for each element in simple list tile
  String get id;

  /// a getter method that will be use by any [SimpleListTile] widget
  /// to display the element within this widget,
  /// usually this getter already exist with a normal data modal class.
  /// this is just a display name that [SimpleListTile] will use
  /// by default but you may override this behavior by
  /// defining "mainText" function in [SimpleListTile]
  String get name;

  /// create a method than will take
  /// [element] as value that this
  /// class will compare with
  /// ***
  /// please make sure this only compare
  /// the [id] and not the entire method
  /// ***
  /// only override this method if you know
  /// what you are doing else do not override this method
  /// and use the default one
  bool idCompare(T element) {
    return id == element.id;
  }
}

extension SimpleListTileExtension<T extends SimpleListTileMixin<T>> on List<T> {
  bool idContain(T element) {
    return any((baseElement) => baseElement.idCompare(element));
  }

  void idRemove(T removeElement) {
    removeWhere((element) => element.idCompare(removeElement));
  }
}
