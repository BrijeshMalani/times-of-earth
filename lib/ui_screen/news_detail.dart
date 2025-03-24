import 'package:flutter/material.dart';
import '../models/news_model.dart';
import '../widgets/banner_ad_widget.dart';
import '../services/interstitial_ad_service.dart';

class NewsDetailPage extends StatefulWidget {
  final News news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  final InterstitialAdService _interstitialAdService = InterstitialAdService();

  @override
  void initState() {
    super.initState();
    _interstitialAdService.loadAd();
  }

  @override
  void dispose() {
    _interstitialAdService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.news.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.news.category,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  // Title
                  Text(
                    widget.news.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Author and date
                  Row(
                    children: [
                      Icon(Icons.person, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        widget.news.author,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        widget.news.date,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Full description
                  Text(
                    widget.news.description,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  // You can add more content sections here
                ],
              ),
            ),
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }

  void _onNewsTap() {
    _interstitialAdService.showAd();
  }
}
