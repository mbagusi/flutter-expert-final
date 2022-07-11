import 'package:core/utils/exception.dart';
import 'package:tv/data/models/tv_table.dart';
import 'package:tv/data/datasources/db/database_helper_tv.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchListTv(TvTable tv);
  Future<String> removeWatchListTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
  Future<List<TvTable>> getWatchListTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelperTv databaseHelperTv;

  TvLocalDataSourceImpl({required this.databaseHelperTv});

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelperTv.getTvById(id);
    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTable>> getWatchListTv() async {
    final result = await databaseHelperTv.getWatchlistTv();
    return result.map((e) => TvTable.fromMap(e)).toList();
  }

  @override
  Future<String> insertWatchListTv(TvTable tv) async {
    try {
      await databaseHelperTv.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchListTv(TvTable tv) async {
    try {
      await databaseHelperTv.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
