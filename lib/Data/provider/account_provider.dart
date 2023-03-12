import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:hub/Admin/screens/Home/HomeScreenAdmin.dart';
import 'package:hub/Common/Util/decrypt.dart';
import 'package:hub/Common/screens/Authentication/Sign_In.dart';
import 'package:hub/Data/provider/account_provider.dart';
import 'package:hub/Data/provider/attendance_provider.dart';
import 'package:hub/Data/provider/connection_string_provider.dart';
import 'package:hub/Data/repository/auth_repo.dart';
import 'package:hub/Employee/screens/Home/HomeScreenEmployee.dart';
import '../repository/response_model.dart';
import '../response/base/api_response.dart';
import '../response/base/error_response.dart';

class AccountProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AccountProvider({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool OtpValue = false;
  bool _isActiveRememberMe = false;
  List<String> codeController = [];

  bool get isActiveRememberMe => _isActiveRememberMe;
  String _loginErrorMessage = '';
  String resultString = '';

  String get loginErrorMessage => _loginErrorMessage;
  String ArabicName = 'اسم الموظف';
  String EnglishName = 'Employee Name';

  Future<ResponseModel> login(
      {required String employeeCode, required String password}) async {
    _isLoading = true;
    _loginErrorMessage = '';
    ApiResponse apiResponse = (await authRepo.login(
        empCode: employeeCode, password: password)) as ApiResponse;
    _isLoading = false;

    ResponseModel responseModel;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
      Map map = apiResponse.response.data;
      String token = map["access_token"];
      String type = await decrypt().decryptInfo(map["type"]);
      String arabicName = map["EmpNameA"];
      String englishName = map["EmpNameE"];
      String englishAddress = map["EmpAddressE"];
      String arabicAddress = map["EmpAddressA"];
      String mobileNumber = map["EmpMobileNo"];
      String email = map["Email"];
      String birthDay = map["BirthDate"];
      String gender = map["Gender"];
      String manager = map["ManagerName"];
      String IqamaNo = map["IqamaNo"];
      String locationE = map["locationE"];
      String locationA = map["locationA"];
      String PositionDescE = map["PositionDescE"];
      String PositionDescA = map["PositionDescA"];
      String companyName = map["companyName"];
      String EmpProfilePhoto = map["EmpProfilePhoto"];

      if (EmpProfilePhoto == "") {
        EmpProfilePhoto = 'https://www.w3schools.com/howto/img_avatar.png';
      }

      authRepo.saveUserType(type);
      authRepo.saveUserToken(token, type);
      authRepo.saveEmpAddress(arabicAddress, englishAddress);
      authRepo.saveEmpMobileNo(mobileNumber);
      authRepo.saveEmpBirthDate(birthDay);
      authRepo.saveEmpGender(gender);
      authRepo.saveEmpEmail(email);
      authRepo.saveEmpManager(manager);
      authRepo.saveUserName(arabicName, englishName);
      authRepo.saveUserNumberAndPassword(employeeCode, password);
      authRepo.saveUserLocation(locationE, locationA);
      authRepo.saveUserPosition(PositionDescE, PositionDescA);
      authRepo.saveUserIqamaNo(IqamaNo);
      authRepo.saveUserCompanyName(companyName);
      authRepo.saveUserEmpProfilePhoto(EmpProfilePhoto);

      responseModel = ResponseModel('', true);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        print(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        print(errorResponse.errors[0].message);
        errorMessage = errorResponse.errors[0].message;
      }
      _loginErrorMessage = errorMessage;
      responseModel = ResponseModel(errorMessage, false);
    }

    return responseModel;
  }

  void notifyAll() {
    notifyListeners();
  }

  toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    notifyListeners();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool isWelcomeScreenAppear() {
    return authRepo.isWelcomeScreenAppear();
  }

  String getEmpUsername() {
    EnglishName = authRepo.getEmpUsername();
    notifyListeners();
    return EnglishName;
  }

  Future<void> reloadUsername() async {
    authRepo.reloadEmpUsername();
  }

  String getEmpUsernameA() {
    ArabicName = authRepo.getEmpUsernameA();
    notifyListeners();
    return ArabicName;
  }

  String detectLang() {
    return authRepo.getLang();
  }

  Future<String> getEmpUsernameFirst() {
    return authRepo.getEmpUsernameFirst();
  }

  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  void putShared(int EmpCode, int val) {
    return authRepo.putShared(EmpCode, val);
  }

  int getShared(int EmpCode) {
    return authRepo.getShared(EmpCode);
  }

  void onSubmitSignIn(BuildContext context, pressAttention,
      _empcodeController, _passwordController, isChecked) {
    _isLoading = true;
    notifyListeners();
      pressAttention = !pressAttention;
      if (WidgetsBinding.instance.window.viewInsets.bottom > 0.0) {
        FocusScope.of(context).unfocus();
      }
      pressAttention = !pressAttention;
      String _empcode = _empcodeController.text.trim();
      String _password = _passwordController.text.trim();
      if (_empcode.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
          content: Text(
            'Invalid company code number'.tr(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ))
            .closed
            .then((value) => pressAttention = !pressAttention);
      } else if (_password.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
          content: Text(
            'Enter password'.tr(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ))
            .closed
            .then((value) => pressAttention = !pressAttention);
      } else {
        Provider.of<AccountProvider>(context, listen: false)
            .login(employeeCode: _empcode, password: _password)
            .then((status) async {
          if (status.isSuccess) {
            _isLoading = false;
            if (Provider.of<AccountProvider>(context, listen: false)
                .isActiveRememberMe &&
                isChecked) {
              Provider.of<AccountProvider>(context, listen: false)
                  .saveUserNumberAndPassword(_empcode, _password);
            } else {
              _isLoading = false;
            }
            if (await Provider.of<AccountProvider>(context, listen: false)
                .isAdmin()) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                content: Text(
                  'Success',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ))
                  .closed
                  .then((value) {
                pressAttention = !pressAttention;
              });
              const HomeScreenAdmin().launch(context);
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                content: Text(
                  'Success',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ))
                  .closed
                  .then((value) => pressAttention = !pressAttention);
              const HomeScreenEmployee().launch(context);
            }
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(
              content: Text(
                status.message,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ))
                .closed
                .then((value) {
              pressAttention = !pressAttention;
            });
          }
        });
      }
  }

  void onSubmitOtp(BuildContext context, showTextVerify, resultString) {
    _isLoading = true;
    notifyListeners();
      FocusScope.of(context).unfocus();
      showTextVerify = true;
      Provider.of<ConnectStringProvider>(context, listen: false)
          .getConnectionUrl(resultString).then((value) =>
      {
        if (value == true) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => const SignIn())),
          codeController.clear(),
          _isLoading = false,
          notifyListeners(),
        } else {
          ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(
            content: Text(
              'Invalid company code number'.tr(),
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          )).closed.then((value) {
              showTextVerify = false;
              _isLoading = false;
              OtpValue = true;
              codeController.clear();
              notifyListeners();
          }),
        }
      });
  }

  Future<void> setCurrentLocation(BuildContext context) async {
    Position userLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await Provider.of<AttendanceProvider>(context, listen: false)
        .attendanceRepo
        .setLocation(userLocation.latitude.toString(),
            userLocation.longitude.toString());
  }

  Future<void> updateToken() async {
    ApiResponse apiResponse = (await authRepo.updateToken()) as ApiResponse;
    if (apiResponse.response != null &&
        apiResponse.response.statusCode == 200) {
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        errorMessage = apiResponse.error.errors[0].message;
      }
      print(errorMessage);
    }
  }

  Future<bool> isAdmin() async {
    return authRepo.isAdmin();
  }

  Future<bool> clearUserEmailAndPassword() async {
    return authRepo.clearUserNumberAndPassword();
  }

  Future<bool> requestPermission(Permission setting) async {
    final _result = await setting.request();
    switch (_result) {
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        return false;
    }
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  Future<bool> clearSharedType() async {
    return await authRepo.clearSharedType();
  }

  Future<bool> clearSharedUserName() async {
    return await authRepo.clearSharedUserName();
  }

  Future<bool> clearSharedUserNameA() async {
    return await authRepo.clearSharedUserNameA();
  }

  Future<bool> clearSharedEmpPhoto() async {
    return await authRepo.clearSharedEmpPhoto();
  }
}
