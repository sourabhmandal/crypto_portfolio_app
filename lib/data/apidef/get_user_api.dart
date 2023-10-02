import 'dart:ffi';

import 'package:gql/src/ast/ast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

DocumentNode getUserApiDocument() => gql(
    """
query GetUserDetailQuery(\$_username: String) {
  getUserByUserName(username: \$_username) {
    username
    walletAddress
  }
}
""");