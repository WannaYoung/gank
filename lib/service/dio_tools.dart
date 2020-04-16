class DioTools {
  static Map<String, dynamic> getParamas(Map<String, dynamic> paramas) {
    Map<String, dynamic> headers = {"deviceId": "6F0EB30E-5D89-4D57-BA80-A645D3916901",
      "deviceType": "iOS",
      "deviceBrand": "iPhone8",
      "token": "token",
      "appChannel": "00",
      "appVersion": "1.0.0",
    };
    return {"headers": headers,
      "body": paramas
    };
  }
}