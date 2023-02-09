import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:customizable_datetime_picker/customizable_datetime_picker_method_channel.dart';

void main() {
  MethodChannelCustomizableDatetimePicker platform = MethodChannelCustomizableDatetimePicker();
  const MethodChannel channel = MethodChannel('customizable_datetime_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
