import 'package:ag/network/model/dtos.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserDTO user;
  String errorMessage;
  bool loading = false;
  List<UserDTO> usersFollowing;

  Future<bool> fetchUser(username) async {
    setLoading(true);
/*
    await Github(username).fetchUser().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });
*/
    return isUser();
  }


  void setUserFollowing(List<UserDTO> usersFollowing){
    this.usersFollowing=usersFollowing;
    notifyListeners();
  }

  List<UserDTO> getUsersFollowing(){
    return usersFollowing;
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(value) {
    user = value;
    notifyListeners();
  }

  UserDTO getUSer() {
    return user;
  }

  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isUser() {
    return user != null ? true : false;
  }
}