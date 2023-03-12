import 'package:local_auth/local_auth.dart';

class BiometricAuth {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;

  Future<bool> canCheckBiometrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    return canCheckBiometrics;
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
    await _localAuthentication.getAvailableBiometrics();
    return availableBiometrics;
  }

  // Future<bool> authenticate() async {
  //   bool authenticated = await _localAuthentication.authenticate(
  //     localizedReason: 'Scan your fingerprint to authenticate',
  //     biometricOnly: true,
  //     stickyAuth: true,
  //   );
  //   return authenticated;
  // }

  Future<void> getBiometricSupport() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    if (!canCheckBiometrics) {
      _supportState = _SupportState.unsupported;
      return;
    }
    List<BiometricType> availableBiometrics =
    await _localAuthentication.getAvailableBiometrics();
    if (availableBiometrics.isEmpty) {
      _supportState = _SupportState.unsupported;
      return;
    }
    _supportState = _SupportState.supported;
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
