import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'customizable_datetime_picker_method_channel.dart';

abstract class CustomizableDatetimePickerPlatform extends PlatformInterface {
  /// Constructs a CustomizableDatetimePickerPlatform.
  CustomizableDatetimePickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomizableDatetimePickerPlatform _instance = MethodChannelCustomizableDatetimePicker();

  /// The default instance of [CustomizableDatetimePickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomizableDatetimePicker].
  static CustomizableDatetimePickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomizableDatetimePickerPlatform] when
  /// they register themselves.
  static set instance(CustomizableDatetimePickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
