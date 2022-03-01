class FormValidater {
  static minCart(String? val, int minVal) {
    if (val == null) {
      return "Bu Alan Zorunlu";
    } else if (val.length <= minVal) {
      return "Bu Alan $minVal Karakterden Küçük Olamaz";
    } else {
      return null;
    }
  }
}
