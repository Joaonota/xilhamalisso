import 'package:xilhamalisso/enum/status_usuario.dart';

class Utilitarios {
  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;
      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int numero) {
    switch (numero) {
      case 0:
        return UserState.Offline;
      case 1:
        return UserState.Online;
      default:
        return UserState.Waiting;
    }
  }
}
