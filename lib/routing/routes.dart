abstract final class Routes {
  static String build({
    String path = "",
    String method = "",
    String param = "",
  }) {
    return "$path$method$param";
  }
}
