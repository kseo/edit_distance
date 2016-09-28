// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import './base.dart';

/// The Levenshtein distance, or edit distance, between two words is the
/// minimum number of single-character edits (insertions, deletions or
/// substitutions) required to change one word into the other.
class Levenshtein implements StringDistance {
  @override
  int distance(String s1, String s2) {
    if (s1 == s2) {
      return 0;
    }

    if (s1.length == 0) {
      return s2.length;
    }

    if (s2.length == 0) {
      return s1.length;
    }

    List<int> v0 = new List<int>(s2.length + 1);
    List<int> v1 = new List<int>(s2.length + 1);
    List<int> vtemp;

    for (var i = 0; i < v0.length; i++) {
      v0[i] = i;
    }

    for (var i = 0; i < s1.length; i++) {
      v1[0] = i + 1;

      for (var j = 0; j < s2.length; j++) {
        int cost = 1;
        if (s1.codeUnitAt(i) == s2.codeUnitAt(j)) {
          cost = 0;
        }
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }

      vtemp = v0;
      v0 = v1;
      v1 = vtemp;
    }

    return v0[s2.length];
  }
}
