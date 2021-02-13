class CouponModel {
  static int couponId;
  static String amount;
  static String type ;
  static String couponName ;
  static int setCouponID(int id) {
    couponId = id;
  }
  static String setAmount(String amountT) {
    amount = amountT;
  }
  static String setDiscountType(String dType) {
    type = dType;
  }
  static String setCouponName(String couponNameAST) {
    couponName = couponNameAST;
  }

}
