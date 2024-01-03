class CoreFrameworkException implements Exception {
  final String message;
  final String? hint;

  CoreFrameworkException({required this.message, this.hint});

  @override
  String toString() => 'message: $message, hint: $hint';
}
