import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/constants/images/images.dart';
import 'package:weatherwise_news_app/core/constants/style/style.dart';
import 'package:weatherwise_news_app/core/utils/extensions.dart';
import 'package:weatherwise_news_app/core/utils/loader.dart';
import 'package:weatherwise_news_app/modules/home/data/models/news_model/get_news_model.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';

class NewsPage extends StatelessWidget {
  final HomeController controller;

  NewsPage({super.key, required this.controller});

  final RxString selectedFilter = 'All News'.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.weatherState.value;

      // Apply filtering logic
      final filteredArticles = _filterArticles(state.getNewsModel.articles ?? []);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Latest News",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
            ),
          ),
          _buildFilterChips(context),
          const SizedBox(height: 8),

          if (state.isNewsLoading && filteredArticles.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: LottieBuilder.asset(AppImageVectors.newsLoading, height: 100),
              ),
            ),

          // Content Section
          Expanded(
            child: filteredArticles.isEmpty
                ? state.isNewsLoading
                    ? LottieBuilder.asset(
                        AppImageVectors.newsLoading,
                        height: 150,
                        width: double.infinity,
                      )
                    : Center(
                        child: Column(
                          spacing: 10,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.newspaper,
                              color: AppColors.primaryWhite,
                              size: 50,
                            ),
                            Text(
                              "No news available right now.",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 16,
                                    color: AppColors.primaryWhite,
                                  ),
                            ),
                            AppStyle.kHeight20,
                          ],
                        ),
                      )
                : NotificationListener<ScrollNotification>(
                    onNotification: (scrollInfo) {
                      if (!state.isNewsLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                        _loadMoreNews();
                      }
                      return true;
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredArticles.length + (state.isNewsLoading ? 1 : 0), // Loader only for pagination
                      separatorBuilder: (_, __) => const Divider(color: Colors.white24),
                      itemBuilder: (context, index) {
                        if (index == filteredArticles.length && state.isNewsLoading) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: LottieBuilder.asset(
                              AppImageVectors.newsLoading,
                              height: 80,
                            ),
                          );
                        }
                        return _buildNewsItem(context, filteredArticles[index]);
                      },
                    ),
                  ),
          ),
        ],
      );
    });
  }

  /// Filter Chips
  Widget _buildFilterChips(BuildContext context) {
    final filters = ['All News', 'Weather News'];

    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Wrap(
          spacing: 12,
          children: filters.map((filter) {
            final isSelected = selectedFilter.value == filter;
            return ChoiceChip(
              label: Text(
                filter,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isSelected ? AppColors.blackText : AppColors.primaryWhite,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
              ),
              selected: isSelected,
              onSelected: (bool selected) {
                if (selected) selectedFilter.value = filter;
              },
              checkmarkColor: isSelected ? AppColors.blackText : AppColors.primaryWhite,
              color: WidgetStatePropertyAll(
                isSelected ? AppColors.whiteText : const Color.fromARGB(255, 118, 84, 166),
              ),
              backgroundColor: AppColors.blackText.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.primaryWhite,
                  width: 1.2,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Build Each News Item
  Widget _buildNewsItem(BuildContext context, Article article) {
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
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return SizedBox(
                    width: 40,
                    height: 40,
                    child: Center(
                      child: CommonLoadingWidget(
                        circleValue: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded / (progress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return SizedBox(
                    height: 80,
                    width: 80,
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      size: 32,
                      color: AppColors.primaryWhite.withValues(alpha: 0.6),
                    ),
                  );
                },
              ),
            )
          : const Icon(Icons.image_not_supported, size: 50, color: Colors.white54),
      title: Text(
        article.title ?? "No title",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.primaryWhite,
              fontSize: 16,
            ),
      ),
      subtitle: Column(
        spacing: 20,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.description ?? "No description",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryWhite.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
          ),
          Text(
            HelperFormatFunctions().formatPublishedDate(article.publishedAt),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryWhite,
                  fontSize: 12,
                ),
          ),
        ],
      ),
      onTap: () {
        if (article.url != null) {
          _openNewsUrl(article.url!);
        }
      },
    );
  }

  /// Weather-based keywords
  List<String> _getWeatherKeywords(String weatherDescription) {
    weatherDescription = weatherDescription.toLowerCase();
    log("keyword : $weatherDescription");
    if (weatherDescription.contains('snow') ||
        weatherDescription.contains('cold') ||
        weatherDescription.contains('clouds') ||
        weatherDescription.contains('rain')) {
      return ['depressing', 'tragedy', 'accident'];
    } else if (weatherDescription.contains('clear') ||
        weatherDescription.contains('sunny') ||
        weatherDescription.contains('hot')) {
      return ['fear', 'danger', 'wildfire'];
    } else if (weatherDescription.contains('cloud') ||
        weatherDescription.contains('warm') ||
        weatherDescription.contains('mild')) {
      return ['winning', 'positivity', 'happiness'];
    } else {
      return ['news'];
    }
  }

  /// Filter logic
  List<Article> _filterArticles(List<Article> articles) {
    if (selectedFilter.value == 'All News') return articles;

    final weatherCondition = controller.weatherState.value.weather;
    final keywords = _getWeatherKeywords(weatherCondition);

    return articles.where((article) {
      final title = article.title?.toLowerCase() ?? '';
      final description = article.description?.toLowerCase() ?? '';
      return keywords.any((keyword) => title.contains(keyword) || description.contains(keyword));
    }).toList();
  }

  void _loadMoreNews() {
    controller.loadNextPage();
  }

  void _openNewsUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}
