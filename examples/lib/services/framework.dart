import 'package:core_management_v2/core_management_v2.dart';
import 'package:core_management_v2/widgets/loading_state_chip.dart';

import 'theme_service.dart';

class FrameworkService extends BaseFrameworkService {
  LoadingStateChipController? _loadingStateChipController;

  @override
  BaseThemeService get themeService => ThemeService();

  @override
  initializeLoadingController(LoadingStateChipController controller) {
    _loadingStateChipController = controller;
  }

  @override
  LoadingStateChipController get loadingStateChipController {
    if (_loadingStateChipController == null) {
      throw Exception('LoadingStateChipController is not initialized');
    }
    return _loadingStateChipController!;
  }

}

final FrameworkService frameworkService = FrameworkService();
