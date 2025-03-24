import 'package:get/get.dart';
import '../models/news_model.dart';

class NewsController extends GetxController {
  var newsList = <News>[].obs;
  var selectedCategory = 'All'.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNews();
  }

  void loadNews() {
    isLoading.value = true;
    // Simulating API call with demo data
    Future.delayed(Duration(seconds: 1), () {
      newsList.value = [
        News(
          title:
              'Breaking: Major Tech Company Announces Revolutionary AI Breakthrough',
          description:
              'A leading technology company has unveiled a groundbreaking artificial intelligence system that promises to transform various industries...',
          imageUrl: 'https://picsum.photos/800/400?random=1',
          category: 'Technology',
          date: '2024-03-20',
          author: 'John Smith',
        ),
        News(
          title: 'Global Climate Summit Reaches Historic Agreement',
          description:
              'World leaders have come together to sign a landmark climate agreement that sets ambitious targets for carbon reduction...',
          imageUrl: 'https://picsum.photos/800/400?random=2',
          category: 'Environment',
          date: '2024-03-19',
          author: 'Sarah Johnson',
        ),
        News(
          title: 'Sports: Underdog Team Makes Stunning Championship Victory',
          description:
              'In an unexpected turn of events, the underdog team has secured their first championship title in decades...',
          imageUrl: 'https://picsum.photos/800/400?random=3',
          category: 'Sports',
          date: '2024-03-18',
          author: 'Mike Wilson',
        ),
        News(
          title: 'New Medical Breakthrough in Cancer Treatment',
          description:
              'Scientists have discovered a promising new approach to treating certain types of cancer...',
          imageUrl: 'https://picsum.photos/800/400?random=4',
          category: 'Health',
          date: '2024-03-17',
          author: 'Dr. Emily Brown',
        ),
        News(
          title: 'Economy: Stock Market Reaches New Heights',
          description:
              'The global stock market has achieved record-breaking levels, driven by strong corporate earnings...',
          imageUrl: 'https://picsum.photos/800/400?random=5',
          category: 'Business',
          date: '2024-03-16',
          author: 'David Chen',
        ),
        News(
          title: 'Space Exploration: Mars Rover Makes New Discovery',
          description:
              'NASA\'s Mars rover has uncovered evidence of ancient microbial life on the red planet...',
          imageUrl: 'https://picsum.photos/800/400?random=6',
          category: 'Science',
          date: '2024-03-15',
          author: 'Dr. Robert Martinez',
        ),
        News(
          title: 'Entertainment: Award-Winning Actor Announces Retirement',
          description:
              'After a decades-long career in Hollywood, the beloved actor has announced their retirement from acting...',
          imageUrl: 'https://picsum.photos/800/400?random=7',
          category: 'Entertainment',
          date: '2024-03-14',
          author: 'Lisa Thompson',
        ),
        News(
          title: 'Education: New Teaching Method Shows Remarkable Results',
          description:
              'A revolutionary teaching approach has demonstrated significant improvements in student performance...',
          imageUrl: 'https://picsum.photos/800/400?random=8',
          category: 'Education',
          date: '2024-03-13',
          author: 'Prof. James Wilson',
        ),
        News(
          title: 'Politics: Major Policy Reform Announced',
          description:
              'The government has unveiled a comprehensive policy reform package aimed at economic recovery...',
          imageUrl: 'https://picsum.photos/800/400?random=9',
          category: 'Politics',
          date: '2024-03-12',
          author: 'Alexandra Green',
        ),
        News(
          title: 'Food: New Sustainable Farming Method Gains Traction',
          description:
              'An innovative farming technique is helping farmers increase yields while reducing environmental impact...',
          imageUrl: 'https://picsum.photos/800/400?random=10',
          category: 'Food',
          date: '2024-03-11',
          author: 'Maria Garcia',
        ),
        News(
          title: 'Art: Contemporary Exhibition Breaks Attendance Records',
          description:
              'A groundbreaking art exhibition has attracted record numbers of visitors...',
          imageUrl: 'https://picsum.photos/800/400?random=11',
          category: 'Art',
          date: '2024-03-10',
          author: 'Thomas Anderson',
        ),
        News(
          title: 'Fashion: Sustainable Clothing Line Launches',
          description:
              'A new fashion brand is making waves with its commitment to sustainable and ethical production...',
          imageUrl: 'https://picsum.photos/800/400?random=12',
          category: 'Fashion',
          date: '2024-03-09',
          author: 'Sophie Chen',
        ),
        News(
          title: 'Travel: New Tourist Destination Emerges',
          description:
              'A previously unknown location has become the latest must-visit destination for travelers...',
          imageUrl: 'https://picsum.photos/800/400?random=13',
          category: 'Travel',
          date: '2024-03-08',
          author: 'Mark Thompson',
        ),
        News(
          title: 'Technology: Quantum Computing Milestone Achieved',
          description:
              'Scientists have reached a significant milestone in quantum computing research...',
          imageUrl: 'https://picsum.photos/800/400?random=14',
          category: 'Technology',
          date: '2024-03-07',
          author: 'Dr. Sarah Chen',
        ),
        News(
          title: 'Health: Breakthrough in Vaccine Development',
          description:
              'Researchers have announced a major breakthrough in vaccine development technology...',
          imageUrl: 'https://picsum.photos/800/400?random=15',
          category: 'Health',
          date: '2024-03-06',
          author: 'Dr. Michael Brown',
        ),
      ];
      isLoading.value = false;
    });
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
  }

  List<News> get filteredNews {
    if (selectedCategory.value == 'All') {
      return newsList;
    }
    return newsList
        .where((news) => news.category == selectedCategory.value)
        .toList();
  }
}
