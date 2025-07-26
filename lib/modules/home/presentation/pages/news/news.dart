import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';

class NewsPage extends StatelessWidget {
  final HomeController controller;
  // final ScrollController scrollController;
  const NewsPage({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.weatherState.value;

      if (state.isNewsLoading) {
        return const Center(
          child: CircularProgressIndicator(color: Colors.white),
        );
      }

      if (state.getNewsModel.articles == null || state.getNewsModel.articles!.isEmpty) {
        return const Center(
          child: Text(
            "No news available right now.",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        );
      }

      final articles = state.getNewsModel.articles!;

      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (!state.isNewsLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // Load next page
            _loadMoreNews();
          }
          return true;
        },
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          // controller: scrollController,
          itemCount: articles.length + 1,
          separatorBuilder: (_, __) => const Divider(color: Colors.white24),
          itemBuilder: (context, index) {
            if (index == articles.length) {
              // Loader at the bottom when loading new page
              return state.isNewsLoading
                  ? const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    )
                  : const SizedBox.shrink();
            }

            final article = articles[index];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: article.urlToImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.urlToImage!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image_not_supported, size: 50, color: Colors.white54),
              title: Text(
                article.title ?? "No title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              subtitle: Text(
                article.description ?? "No description",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              onTap: () {
                // Open article URL
                if (article.url != null) {
                  _openNewsUrl(article.url!);
                }
              },
            );
          },
        ),
      );
    });
  }

  /// Load the next page of news
  void _loadMoreNews() {
    final state = controller.weatherState.value;
    final currentPage = state.getNewsModel.articles?.length ?? 0;
    final nextPage = (currentPage ~/ 10) + 1; // each page = 10 items
    controller.getNewsData(country: "us", page: nextPage, pageSize: 10);
  }

  void _openNewsUrl(String url) {
    // Implement with url_launcher
  }
}
