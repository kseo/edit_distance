// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import './base.dart';

/// Implementation of Damerau-Levenshtein distance with transposition (also
/// sometimes calls unrestricted Damerau-Levenshtein distance).
/// It is the minimum number of operations needed to transform one string into
/// the other, where an operation is defined as an insertion, deletion, or
/// substitution of a single character, or a transposition of two adjacent
/// characters.
///
/// It does respect triangle inequality, and is thus a metric distance.
///
/// This is not to be confused with the optimal string alignment distance, which
/// is an extension where no substring can be edited more than once.
class Damerau implements StringDistance {
  @override
  int distance(String s1, String s2) {
    int inf = s1.length + s2.length;

    Map<int, int> da = new Map<int, int>();

    for (var d = 0; d < s1.length; d++) {
      if (!da.containsKey(s1.codeUnitAt(d))) {
        da[s1.codeUnitAt(d)] = 0;
      }
    }

    for (var d = 0; d < s2.length; d++) {
      if (!da.containsKey(s2.codeUnitAt(d))) {
        da[s2.codeUnitAt(d)] = 0;
      }
    }

    List<List<int>> h = new List<List<int>>(s1.length + 2)
        .map((_) => new List<int>.filled(s2.length + 2, 0))
        .toList();

    for (var i = 0; i <= s1.length; i++) {
      h[i + 1][0] = inf;
      h[i + 1][1] = i;
    }

    for (var j = 0; j <= s2.length; j++) {
      h[0][j + 1] = inf;
      h[1][j + 1] = j;
    }

    for (var i = 1; i <= s1.length; i++) {
      int db = 0;

      for (var j = 1; j <= s2.length; j++) {
        int i1 = da[s2.codeUnitAt(j - 1)];
        int j1 = db;

        int cost = 1;
        if (s1.codeUnitAt(i - 1) == s2.codeUnitAt(j - 1)) {
          cost = 0;
          db = j;
        }

        h[i + 1][j + 1] = [
          h[i][j] + cost, // substitution
          h[i + 1][j] + 1, // insertion
          h[i][j + 1] + 1, // deletion
          h[i1][j1] + (i - i1 - 1) + 1 + (j - j1 - 1)
        ].reduce((acc, val) => min(acc, val));
      }
      da[s1.codeUnitAt(i - 1)] = i;
    }

    return h[s1.length + 1][s2.length + 1];
  }
}
