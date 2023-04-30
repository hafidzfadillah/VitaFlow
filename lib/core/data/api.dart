class Api {
  // Base Api Endpoint
  static const _baseServer = "https://vita.akutegar.com/api/v1";

  /// * -------------------
  ///  * VitaMart Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some categories and product vitamart
  /// */

  String getCategories = "$_baseServer/categories";
  String getProducts = "$_baseServer/products";

  /// * -------------------
  /// * User Endpoint
  /// * ------------------
  /// * In this field will exists
  /// * some user endpoint
  /// */
  

  String login = "$_baseServer/auth/login";
}
