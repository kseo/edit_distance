// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import './base.dart';

/// The longest common subsequence (LCS) problem consists in finding the longest
/// subsequence common to two (or more) sequences. It differs from problems of
/// finding common substrings: unlike substrings, subsequences are not required
/// to occupy consecutive positions within the original sequences.
///
/// The LCS distance between Strings X (length n) and Y (length m) is n + m - 2 *
/// |LCS(X, Y)| min = 0 max = n + m
///
/// LCS distance is equivalent to Levenshtein distance, when only insertion and
/// deletion is allowed (no substitution), or when the cost of the substitution
/// is the double of the cost of an insertion or deletion.
///
/// A space requirement O(m * n)!
class LongestCommonSubsequence implements StringDistance {
  @override
  int distance(String s1, String s2) =>
      s1.length + s2.length - 2 * _length(s1, s2);

  /// Returns the length of Longest Common Subsequence (LCS) between strings [s1]
  /// and [s2].
  int _length(String s1, String s2) {
    int m = s1.length;
    int n = s2.length;
    List<int> x = s1.codeUnits;
    List<int> y = s2.codeUnits;

    List<List<int>> c =
        new List<List<int>>(m + 1).map((_) => new List<int>(n + 1)).toList();

    for (var i = 0; i <= m; i++) {
      c[i][0] = 0;
    }

    for (var j = 0; j <= n; j++) {
      c[0][j] = 0;
    }

    for (var i = 1; i <= m; i++) {
      for (var j = 1; j <= n; j++) {
        if (x[i - 1] == y[j - 1]) {
          c[i][j] = c[i - 1][j - 1] + 1;
        } else {
          c[i][j] = max(c[i][j - 1], c[i - 1][j]);
        }
      }
    }

    return c[m][n];
  }
}
