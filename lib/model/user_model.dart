class UserModel {
  static String userType;
  static String accessToken;
  static String userId;
  static int farmerID;
  static String setUserType(String type) {
    userType = type;
  }
  static String setAccessToken(String token) {
    accessToken = token;
  }
  static String setUserId(String id) {
    userId = id;
  }
  static int setFarmerId(int fid) {
    farmerID = fid;
  }
}
