class ApiEndpoints {
  ApiEndpoints._();
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWI5ZDNmOTc4YjZjZmQ4ZGRmM2ZjMjIiLCJpYXQiOjE3MDY5NjkyNDR9.IDWQ1DM-xTt_6QWj692elFb_qauEAm_mwHm_RPavIXA";
  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Windows
  static const String baseUrl = "http://10.0.2.2:5000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "login";
  static const String register = "register";
  static const String searchUserByName = "search";
  static const String followUser = "follow/:id";

  // ====================== Post Routes =======================
  static const String createPost = "post/upload";
  static const String getPostOfFollowingUsers = "posts";
  static const String likeAndUnlikePost = "/post/:id";
}
