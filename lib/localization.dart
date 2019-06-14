import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalization {
  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'name': 'Name',
      'title': 'BAC',
      'weight': 'Weight (pounds)',
      'hours': 'Hours for BAC to reach 0',
      'drinks': 'Cups',
      'message': 'In every state of the United States it is illegal to drive with a BAC of 0.08 or higher.',
      'message2': 'Remember that this value is a close approximation. Do not drive under the influence of alcohol!',
      'warning': 'Must type something before procceding!',
      'list1': 'Reduced Sensitivity\n Well Being',
      'list2': 'Altered Emotions and Behavior\n Relaxation feelings\n  Mild Sedetation',
      'list3': 'Muscle and speech impaired\n Reduced sensitivity\n', 
      'list4': 'Mental Functions Affected\n Difficulty Standing, Walking\n  Euphoria',
      'list5': 'Lethal Dosage\n alcohol poisoning\n',
    },
    'es': {
      'name': 'Entre su nombre',
      'title': 'BAC en la sangre',
      'weight': 'Entre su peso (libras)',
      'hours': 'Horas para que BAC alcance 0',
      'drinks': 'Entre el número de alcohol que tuvo',
      'message': 'En el Peru no es permitido mananejar con un BAC de 0.05 o mas.',
      'warning': 'Debe escribir algo antes de proceder!',
      'list1': 'Sensibilidad reducida \n bienestar',
      'list2': 'Emociones y comportamientos alterados \n Sentimientos de relajación \n Seducción leve',
      'list3': 'Discapacidad muscular y del habla \n Sensibilidad reducida \n', 
      'list4': 'Funciones mentales afectadas \n Dificultad para pararse, caminar \n Euforia',
      'list5': 'Lethal Dosage\n alcohol poisoning\n',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode][key];
  }
}


class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalization> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}