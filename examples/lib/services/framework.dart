import 'package:core_management_v2/core_management_v2.dart';

import 'theme_service.dart';

class FrameworkService extends BaseFrameworkService {
  @override
  BaseThemeService get themeService => ThemeService();
}

final FrameworkService frameworkService = FrameworkService();
