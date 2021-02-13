

import 'dart:io';

class PackageModel {
  static String pickUpLocation;
  static String dropLocation;
  static String pickUpDateAndTime;
  static String packageTypes;
  static String packageDesc;
  static double sourceLat;
  static double sourceLong;
  static double destLat;
  static double destLong;
  static List<File> imageList;


  static String setPickUpLocation(String locName) {
    pickUpLocation = locName;
  }
  static String setDropLocation(String loName) {
    dropLocation = loName;
  }

  static String setPickDate(String date) {
    pickUpDateAndTime = date;
  }


  static String setPackageType(String type) {
    pickUpDateAndTime = type;
  }

  static String setPackageDesc(String desc) {
    packageDesc = desc;
  }


  static double setPickUpLat(double latt) {
    sourceLat = latt;
  }


  static double setPickUpLong(double long1) {
    sourceLong = long1;
  }

  static double setDropLat(double latt1) {
    destLat= latt1;
  }

  static double setDropLong(double long) {
    destLong = long;
  }

  static List<File> setImageList(List<File> fileList) {
    imageList = fileList;
  }
}
