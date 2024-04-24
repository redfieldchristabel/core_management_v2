import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension TaskHelper on State {
  /// Run a task using [WidgetsBinding.instance.addPostFrameCallback] with
  /// checking for mounted state using  [mounted].
  @Deprecated('Use "TaskQueueMixin" or "ConsumerTaskQueueMixin" instead.')
  void addTask(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        callback();
      } else {
        print("task is not run due to widget is not mounted");
      }
    });
  }
}

extension TaskHelperStateless on ConsumerWidget {
  /// Run a task using [WidgetsBinding.instance.addPostFrameCallback]
  void addTask(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) => callback());
  }
}

mixin ConsumerTaskQueueMixin<T extends ConsumerStatefulWidget>
on ConsumerState<T> {
  final Queue<VoidCallback> _taskQueue = Queue();

  /// Enqueue a task to be executed sequentially using [WidgetsBinding.instance.addPostFrameCallback]
  /// with checking for mounted state using [mounted].
  void enqueueTask(VoidCallback callback) {
    _taskQueue.add(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          callback();
        } else {
          print("Task is not run due to widget is not mounted");
        }
        // Process the next task in the queue
        _processTaskQueue();
      });
    });

    // If the queue only has this task, start processing the queue
    if (_taskQueue.length == 1) {
      _processTaskQueue();
    }
  }

  void _processTaskQueue() {
    if (_taskQueue.isNotEmpty) {
      _taskQueue.removeFirst()();
    }
  }
}
mixin TaskQueueMixin<T extends StatefulWidget> on State<T> {
  final Queue<VoidCallback> _taskQueue = Queue();

  /// Enqueue a task to be executed sequentially using [WidgetsBinding.instance.addPostFrameCallback]
  /// with checking for mounted state using [mounted].
  void enqueueTask(VoidCallback callback) {
    _taskQueue.add(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          callback();
        } else {
          print("Task is not run due to widget is not mounted");
        }
        // Process the next task in the queue
        _processTaskQueue();
      });
    });

    // If the queue only has this task, start processing the queue
    if (_taskQueue.length == 1) {
      _processTaskQueue();
    }
  }

  void _processTaskQueue() {
    if (_taskQueue.isNotEmpty) {
      _taskQueue.removeFirst()();
    }
  }
}
