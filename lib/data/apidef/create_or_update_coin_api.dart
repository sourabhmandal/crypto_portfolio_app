import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode createOrUpdateCoinApiDocument() => gql("""
mutation AddCoinMute(\$symbol: String, \$price: String) { #the argument will be of type Integer
  upsertCoin(symbol: \$symbol, price: \$price) {
    #get the person with the ID of 1
    symbol
    price
    id
  }
}
""");
