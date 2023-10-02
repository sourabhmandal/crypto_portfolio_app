import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode createUserBalanceDocument() => gql("""
mutation UpsertBalanceMut(\$walletAddress: String, \$symbol: String, \$balance: String) {
  upsertBalance(
    walletAddress: \$walletAddress
    symbol: \$symbol
    balance: \$balance
  ) {
    balance
    value
    walletAddress
    symbol
  }
}
""");
