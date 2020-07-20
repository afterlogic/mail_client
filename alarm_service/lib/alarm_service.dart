import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/services.dart';

class AlarmService {
  static const MethodChannel _channel = const MethodChannel('alarm_service');
  static final Map<int, Function> _onAlarmMap = {};
  static bool _isInit = false;
  static Duration _iosInterval;
  static Timer _timer;

  static init() {
    if (!_isInit) {
      _isInit = true;
      _doOnAlarm();
    }
  }

  static Future setAlarm(
    Function onAlarm,
    int id,
    Duration interval,
  ) {
    if (Platform.isIOS) {
      initTimer(interval);
    }
    return _channel.invokeMethod('setAlarm', [
      PluginUtilities.getCallbackHandle(onAlarm).toRawHandle(),
      id,
      interval.inSeconds,
    ]);
  }

  /***
   * ios foreground alarm
   ***/
  static initTimer(Duration interval) {
    _iosInterval = interval;
    startTimer();
  }

  static startTimer() {
    stopTimer();
    if (_iosInterval == null) return;
    _timer = Timer.periodic(_iosInterval, (_) => alarm(-1));
  }

  static stopTimer() {
    _timer?.cancel();
  }

  /***
   * flag hasNewData only for ios
   ***/
  static Future endAlarm(bool hasNewData) {
    return _channel.invokeMethod('endAlarm', [hasNewData]);
  }

  static Future removeAlarm(int id) {
    _onAlarmMap.remove(id);
    return _channel.invokeMethod('removeAlarm', [id]);
  }

  static onAlarm(
    Function onAlarm,
    int id,
  ) {
    if (onAlarm == null) {
      _onAlarmMap.remove(id);
    } else {
      _onAlarmMap[id] = onAlarm;
    }
  }

  static _doOnAlarm() async {
    while (true) {
      try {
        final id = (await _channel.invokeMethod('doOnAlarm')) as int;
        alarm(id);
      } catch (e) {}
    }
  }

  static alarm(int id) {
    if (id != null) {
      final function = id == -1 ? _onAlarmMap.values.first : _onAlarmMap[id];
      if (function != null) function();
    }
  }
}
