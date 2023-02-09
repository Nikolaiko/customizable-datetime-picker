import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'customizable_datetime_picker_platform_interface.dart';

/// An implementation of [CustomizableDatetimePickerPlatform] that uses method channels.
class MethodChannelCustomizableDatetimePicker extends CustomizableDatetimePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('customizable_datetime_picker');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
