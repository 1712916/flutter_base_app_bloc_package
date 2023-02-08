

## Description

This package provide a base project base:
  - flutter_bloc (cubit): to management state 
  - get_it: dependency injection
  - dio: to connect http 
  - curl_logger_dio_interceptor: log http request and response
  - ...

I designed a base page and base bloc to save time, and easy to develop new feature when make project more expansive.


## When you can use it?

In case: you want to seprate your project to more repository for easy manage source code, separate team, separate feature but all feature be launch in only a common app and it be deloyed to app store.

Or:
Clone this package and use `terminal flutter create .` to create android/ios project...so let code like normal way

## Usage
add packge to pubspec.yaml

import 'package:flutter_base_app_bloc_package/flutter_base_app_bloc_package.dart';

```dart
//call to open view
GateWay.openApp(context, initRouteName: '/example'); //(1)

//call to close (1)
Navigator.of(mainAppContext!).pop();
```
