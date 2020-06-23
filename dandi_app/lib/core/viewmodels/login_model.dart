import 'package:provider_architecture/core/enums/viewstate.dart';
import 'package:provider_architecture/core/services/authentication_service.dart';
import 'package:provider_architecture/core/viewmodels/base_model.dart';

import '../../locator.dart';

 /// Represents the state of the view

class LoginModel extends BaseModel{
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  String errorMessage;

  Future<bool> login(String userIdText) async {
    setState(ViewState.Busy);

    var userId = int.tryParse(userIdText);

    // Not a number
    if(userId == null){
      errorMessage = 'value entered is not a number';
      setState(ViewState.Idle);
      return false;
    }
    var success = await _authenticationService.login(userId);

    // Handle additional error here. Put the above log

    setState(ViewState.Idle);
    return success;
  }
}