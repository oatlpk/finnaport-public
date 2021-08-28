class CategoryModel {
  String categoryName;
}

List<CategoryModel> getCategories() {
  List<CategoryModel> myCategories = [];
  CategoryModel categoryModel;

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Business';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'Entertainment';
  myCategories.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = 'General';
  myCategories.add(categoryModel);

  return myCategories;
}
