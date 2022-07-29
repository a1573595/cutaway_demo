enum AppPage {
  splash('Splash', 'splash'),
  firstGuide('First Guide', 'firstGuide'),
  home('Home', 'home'),
  notification('Notification', 'notification'),
  notificationDetail('Notification Detail', 'notificationDetail'),
  welcome('Welcome', 'welcome'),
  register('Register', 'register'),
  login('Login', 'login');

  const AppPage(this.name, this.path);

  final String name;
  final String path;

  String get fullPath => '/$path';
}
