class Api {
  // Base Api Endpoint
  static const _baseServer = "https://vita.akutegar.com/api/v1";

  /// * -------------------
  ///  * VitaMart Endpoint
  ///  * ------------------
  ///  * In this field will exists
  ///  * some categories and product vitamart
  /// */
  ///

  String getCategories = "$_baseServer/categories";
  String getProducts = "$_baseServer/products";

  /// * -------------------
  /// * User Endpoint
  /// * ------------------
  /// * In this field will exists
  /// * some user endpoint
  /// */
  String submitSurvey = "$_baseServer/survey";
  String login = "$_baseServer/auth/login";
  String register = "$_baseServer/auth/register";
  String getUser = "$_baseServer/auth/me";
  String getDailyData = "$_baseServer/getDailyData";
  String storeDrink = "$_baseServer/drink/store";
  String historyDrink = "$_baseServer/drink/history";
  String historyFood = "$_baseServer/foods-track/history";

  /// * -------------------
  ///   * Product Endpoint
  ///  * ------------------
  ///

  String getProductsByCategory = "$_baseServer/products";
  String searchProduct = "$_baseServer/product/search";

  /// * -------------------
  /// * Article Endpoint

  String getArticles = "$_baseServer/articles";

  /// * -------------------
  /// * fOOD
  ///
  String getFoods = "$_baseServer/foods";
  String searchFood = "$_baseServer/food/search";
  String storeFoods = "$_baseServer/foods-track/store";

  String vitabot = "$_baseServer/vitabot";
  String storeBpm = "$_baseServer/health-track/store";
  String getBpm = "$_baseServer/health-track/history?days=1";

  /// * -------------------
  /// * Program Endpoint
  String getProgram = "$_baseServer/programs";

  /// * -------------------

   /// * -------------------
  /// * Weight endpoint
  String getWeight = "$_baseServer/weight-track/history";
  String storeWeight = "$_baseServer/weight-track/store";
}
