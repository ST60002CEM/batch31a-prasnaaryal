class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // For Windows
  static const String baseUrl = "https://hamropasal-be.onrender.com/api";
  // For Windows
  // static const String baseUrl = "http://192.168.137.1:3000/api/v1/";
  // static const String baseUrl = "http://192.168.137.1:3000/api/v1/";
  // For MAC
  //static const String baseUrl = "http://localhost:3000/api/v1/";
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  //  static String usertoken =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1OTczNjUzYTE1ODM3MGNiZmY2YzljNSIsImlhdCI6MTcwNTQ2OTYwNCwiZXhwIjoxNzA4MDYxNjA0fQ.unNGpnBGAvizxZqar-hPDzWZ_LaMvdObXq5eeeVI3kY";

  // ====================== Auth Routes ======================
  static const String login = "$baseUrl/auth/login";
  static const String register = "$baseUrl/auth/register";
  // static const String getAllStudent = "auth/getAllStudents";
  // static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  // static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  // static const String updateStudent = "auth/updateStudent/";
  // static const String deleteStudent = "auth/deleteStudent/";
  static const String imageUrl = "";
  static const String uploadImage = "";
  static const String getAllProducts = "$baseUrl/product/getallproducts";
  static const String getCategories = "$baseUrl/category/";
  static const String getProfile= "$baseUrl/user/load-user";
}
