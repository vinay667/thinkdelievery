class AddressModel {
  static String flatNo;
  static String addressType;
  static String road;
  static String state;
  static int addressID;
  static int pinCode;
  static String setFlatNo(String flat) {
    flatNo = flat;
  }
  static String setAddressType(String type) {
    addressType = type;
  }
  static String setRoad(String roadT) {
    road = roadT;
  }

  static String setStateName(String stateName) {
    state = stateName;
  }


  static int setAddressID(int aid) {
    addressID = aid;
  }

  static int setPinCode(int pin) {
    pinCode = pin;
  }
}
