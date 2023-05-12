import 'package:movie_propnext/presentation/provider/tv/tv_popular_notifier.dart';
import 'package:flutter/material.dart';
import 'package:movie_propnext/presentation/widgets/tv_card_list.dart';
import 'package:provider/provider.dart';
import 'package:movie_propnext/common/state_enum.dart';

class PopularTelevisionPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTelevisionPageState createState() => _PopularTelevisionPageState();
}

class _PopularTelevisionPageState extends State<PopularTelevisionPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTvNotifier>(context, listen: false)
            .fetchPopularTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            if (data.state == requestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == requestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvs = data.tv[index];
                  return TvCard(tvs);
                },
                itemCount: data.tv.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
