import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_x.dart';

// global_middleware.dart
// import 'package:get/get.dart';

// class GlobalMiddleware extends GetMiddleware {}

GetPage cGetPageInitial<T extends BaseXWidget>(T page, {Bindings binding}) {
  return GetPage(name: page.routeName, page: () => page, binding: binding);
}

//[GlobalMiddleware()]
GetPage cGetPage<T extends BaseXWidget>(
  T page, {
  Bindings binding,
  List<GetMiddleware> middlewares,
}) {
  return GetPage(
    name: page.routeName,
    page: () {
      T _page = Get.arguments;
      return _page;
    },
    binding: binding,
    middlewares: middlewares,
  );
}

Future<dynamic> loadPage(BaseXWidget page, {bool preventDuplicates = true}) async {
  var result =
      await Get.toNamed(page.routeName, arguments: page, preventDuplicates: preventDuplicates);
  return result;
}

loadPageWithRemovePrevious(BaseXWidget toRoute, BaseXWidget fromRoute) {
  Get.offNamedUntil(toRoute.routeName, ModalRoute.withName(fromRoute.routeName),
      arguments: toRoute);
}

loadPageWithRemoveAllPrevious(
  BaseXWidget page,
) {
  Get.offNamedUntil(page.routeName, (route) => route == null, arguments: page);
}

backTo(BaseXWidget page) {
  Get.until((route) => Get.currentRoute == page.routeName);
}

T getController<T extends GetxController>(T controller) {
  if (Get.isRegistered<T>()) {
    return Get.find<T>();
  } else {
    return null;
  }
}
