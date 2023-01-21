import 'package:najikkopasal/api/userapi.dart';
import 'package:najikkopasal/response/profile_response.dart';

class ProfileRepository {
  Future<ProfileResponse?> getuserprofilefromapi() async {
    return UserAPI().fetchUserfromapi();
  }
}
