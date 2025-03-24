import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/news_model.dart';
import '../ui_screen/news_detail.dart';

class NewsHome extends StatelessWidget {
  final NewsController controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Portal'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return _buildWebLayout();
          } else if (constraints.maxWidth > 600) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        // Sidebar with categories
        Container(
          width: 250,
          color: Colors.grey[100],
          child: _buildCategoryList(),
        ),
        // Main content
        Expanded(
          child: _buildNewsGrid(3),
        ),
      ],
    );
  }

  Widget _buildTabletLayout() {
    return Column(
      children: [
        // Category chips at top
        Container(
          height: 60,
          child: _buildCategoryChips(),
        ),
        // News grid
        Expanded(
          child: _buildNewsGrid(2),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Category chips at top
        Container(
          height: 60,
          child: _buildCategoryChips(),
        ),
        // News list
        Expanded(
          child: _buildNewsList(),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        ...[
          'All',
          'Technology',
          'Environment',
          'Sports',
          'Health',
          'Business',
          'Science',
          'Entertainment',
          'Education',
          'Politics',
          'Food',
          'Art',
          'Fashion',
          'Travel'
        ]
            .map((category) => ListTile(
                  title: Text(category),
                  selected: controller.selectedCategory.value == category,
                  onTap: () => controller.filterByCategory(category),
                ))
            .toList(),
      ],
    );
  }

  Widget _buildCategoryChips() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: 8,
      itemBuilder: (context, index) {
        final categories = [
          'All',
          'Technology',
          'Environment',
          'Sports',
          'Health',
          'Business',
          'Science',
          'Entertainment',
          'Education',
          'Politics',
          'Food',
          'Art',
          'Fashion',
          'Travel'
        ];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: FilterChip(
            label: Text(categories[index]),
            selected: controller.selectedCategory.value == categories[index],
            onSelected: (selected) {
              if (selected) {
                controller.filterByCategory(categories[index]);
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildNewsGrid(int crossAxisCount) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: controller.filteredNews.length,
        itemBuilder: (context, index) {
          return _buildNewsCard(controller.filteredNews[index]);
        },
      );
    });
  }

  Widget _buildNewsList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: controller.filteredNews.length,
        itemBuilder: (context, index) {
          return _buildMobileNewsCard(controller.filteredNews[index]);
        },
      );
    });
  }

  Widget _buildNewsCard(News news) {
    return InkWell(
      onTap: () => Get.to(() => NewsDetailPage(news: news)),
      child: Card(
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.category,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      news.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      news.description,
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news.author,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          news.date,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNewsCard(News news) {
    return InkWell(
      onTap: () => Get.to(() => NewsDetailPage(news: news)),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.only(bottom: 16),
        child: IntrinsicHeight(
          // This ensures proper height calculation
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image section
              Container(
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(news.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.category,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        news.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        news.description,
                        style: TextStyle(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            news.author,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            news.date,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
