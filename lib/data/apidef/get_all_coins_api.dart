import 'dart:ffi';

import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode getAllCoinsApiDocument() => gql(
    """
query GetAllCoinsDataQuery {
  getAllCoins {
    id
    symbol
    price
  }
}
""");