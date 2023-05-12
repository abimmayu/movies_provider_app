import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_propnext/common/constant.dart';
import 'package:movie_propnext/domain/entities/tv/tv.dart';
import 'package:movie_propnext/presentation/pages/movies/home_movie_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_detail_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_popular_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_search_page.dart';
import 'package:movie_propnext/presentation/pages/tv/tv_top_rated.dart';
import 'package:movie_propnext/presentation/provider/tv/tv_list_notifier.dart';
import 'package:provider/provider.dart';
import 'package:movie_propnext/common/state_enum.dart';

class HomeTelevisionPage extends StatefulWidget {
  @override
  _HomeTelevisionPageState createState() => _HomeTelevisionPageState();
  static const ROUTE_NAME = '/tv';
}

class _HomeTelevisionPageState extends State<HomeTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingTv()
      ..fetchPopularTv()
      ..fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Misaflix'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTelevisionPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing TV',
                style: kHeading6,
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingTvState;
                if (state == requestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == requestState.Loaded) {
                  return TvList(data.nowPlayingTv);
                } else {
                  return Text('Failed to connect to the network');
                }
              }),
              _buildSubHeading(
                title: 'Popular TV',
                onTap: () => Navigator.pushNamed(
                    context, PopularTelevisionPage.ROUTE_NAME),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.popularTvState;
                if (state == requestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == requestState.Loaded) {
                  return TvList(data.popularTv);
                } else {
                  return Text('Failed to connect to the network');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated TV',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTelevisionPage.ROUTE_NAME),
              ),
              Consumer<TvListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTvState;
                if (state == requestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == requestState.Loaded) {
                  return TvList(data.topRatedTv);
                } else {
                  return Text('Failed to connect to the network');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tv;

  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvs = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TelevisionDetailPage.ROUTE_NAME,
                  arguments: tvs.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvs.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tv.length,
      ),
    );
  }
}
