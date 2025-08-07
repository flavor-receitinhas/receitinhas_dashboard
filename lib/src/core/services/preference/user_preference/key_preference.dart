enum KeyPreferences {
  ///Escolher qual o tema
  isThemeLight(defaultValue: true),
  //Sessão do usuário
  userSession(defaultValue: ''),
  ///Escolher idioma
  language(defaultValue:'pt');

  final dynamic defaultValue;

  const KeyPreferences({this.defaultValue});
}
