enum IconsSvgEnum {
  person(path: 'assets/icons/person.svg'),
  persons(path: 'assets/icons/persons.svg'),
  key(path: 'assets/icons/key.svg'),
  moon(path: 'assets/icons/moon.svg'),
  eye(path: 'assets/icons/eye.svg'),
  document(path: 'assets/icons/document.svg'),
  logOut(path: 'assets/icons/log_out.svg'),
  save(path: 'assets/icons/save.svg'),
  home(path: 'assets/icons/home.svg'),
  favorite(path: 'assets/icons/favorite.svg'),
  settings(path: 'assets/icons/settings.svg'),
  edit(path: 'assets/icons/edit.svg'),
  cheese(path: 'assets/icons/cheese.svg'),
  watermelon(path: 'assets/icons/watermelon.svg'),
  chicken(path: 'assets/icons/chicken.svg'),
  fish(path: 'assets/icons/fish.svg'),
  wheat(path: 'assets/icons/wheat.svg'),
  milk(path: 'assets/icons/milk.svg'),
  like(path: 'assets/icons/like.svg'),
  clockExpress(path: 'assets/icons/clock_express.svg'),
  coffes(path: 'assets/icons/coffes.svg'),
  carrot(path: 'assets/icons/carrot.svg'),
  knife(path: 'assets/icons/knife.svg'),
  pan(path: 'assets/icons/pan.svg'),
  delete(path: 'assets/icons/delete.svg'),
  clock(path: 'assets/icons/clock.svg'),
  fire(path: 'assets/icons/fire.svg'),
  pot(path: 'assets/icons/pot.svg'),
  menu(path: 'assets/icons/menu.svg'),
  fireRounded(path: 'assets/icons/fire_rounded.svg'),
  changeLannguage(path: 'assets/icons/change_language.svg'),
  search(path: 'assets/icons/search.svg'),
  heart(path: 'assets/icons/heart.svg');

  final String path;

  const IconsSvgEnum({required this.path});
}

enum ImagesEnum {
  ovo('assets/images/ovo.png'),
  eggCooking('assets/images/egg_cooking.png'),
  eggDuvida('assets/images/egg_duvida.png'),
  eggEspadachim('assets/images/egg_espadachim.png'),
  eggError('assets/images/egg_error.png'),
  eggForget('assets/images/egg_forget.png'),
  eggHello('assets/images/egg_hello.png'),
  avatar('assets/images/avatar.png'),
  home('assets/images/home.png'),
  logo('assets/images/logo.png'),
  eggImageNotFound('assets/images/ovo_image_not_found.png'),
  google('assets/images/google_logo.png');

  final String path;
  const ImagesEnum(this.path);
}
