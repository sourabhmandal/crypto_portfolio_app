import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode getUserBalanceDocument() => gql("""
query GetAllWalletBalanceQuery(\$walletAddress: String, \$symbol: String) {
  getAllWalletBalances(walletAddress: \$walletAddress, symbol: \$symbol) {
    walletAddress
    balance
    symbol
    value
  }
}
""");
