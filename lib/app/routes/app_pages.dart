part of 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    //Common pages
    cGetPageInitial(MainPage(), binding: MainBindings()),

    //Menu
    cGetPage(MenuPage(), binding: MenuBinding()),
  ];
}
