import 'package:flutter_test/flutter_test.dart';
import 'package:customizable_datetime_picker/customizable_datetime_picker.dart';
import 'package:customizable_datetime_picker/customizable_datetime_picker_platform_interface.dart';
import 'package:customizable_datetime_picker/customizable_datetime_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomizableDatetimePickerPlatform
    with MockPlatformInterfaceMixin
    implements CustomizableDatetimePickerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomizableDatetimePickerPlatform initialPlatform = CustomizableDatetimePickerPlatform.instance;

  test('$MethodChannelCustomizableDatetimePicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomizableDatetimePicker>());
  });

  test('getPlatformVersion', () async {
    CustomizableDatetimePicker customizableDatetimePickerPlugin = CustomizableDatetimePicker();
    MockCustomizableDatetimePickerPlatform fakePlatform = MockCustomizableDatetimePickerPlatform();
    CustomizableDatetimePickerPlatform.instance = fakePlatform;

    expect(await customizableDatetimePickerPlugin.getPlatformVersion(), '42');
  });
}
