// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:math' as math;

import './base.dart';

const defaultThreshold = 0.7;
const jwCoef = 0.1;

/// The Jaro–Winkler distance metric is designed and best suited for short
/// strings such as person names, and to detect typos; it is (roughly) a
/// variation of Damerau-Levenshtein, where the substitution of 2 close
/// characters is considered less important then the substitution of 2 characters
/// that a far from each other.
///
/// Jaro-Winkler was developed in the area of record linkage (duplicate
/// detection) (Winkler, 1990). It returns a value in the interval [0.0, 1.0].
/// The distance is computed as 1 - Jaro-Winkler similarity.
class JaroWinkler implements NormalizedStringDistance {
  /// The current value of the threshold used for adding the Winkler bonus.
  final double threshold;

  /// Creates an instance with given threshold to determine when Winkler bonus
  /// should be used.
  JaroWinkler([this.threshold = defaultThreshold]);

  @override
  double normalizedDistance(String s1, String s2) => 1.0 - _similarity(s1, s2);

  double _similarity(String s1, String s2) {
    List<int> mtp = _matches(s1, s2);
    final m = mtp[0];
    if (m == 0) {
      return 0.0;
    }
    double j = ((m / s1.length + m / s2.length + (m - mtp[1]) / m)) / 3;
    double jw = j;

    if (j > threshold) {
      jw = j + math.min(jwCoef, 1.0 / mtp[3]) * mtp[2] * (1 - j);
    }
    return jw;
  }

  List<int> _matches(String s1, String s2) {
    String max, min;
    if (s1.length > s2.length) {
      max = s1;
      min = s2;
    } else {
      max = s2;
      min = s1;
    }
    int range = math.max(max.length ~/ 2 - 1, 0);
    List<int> matchIndexes = new List<int>.filled(min.length, -1);
    List<bool> matchFlags = new List<bool>.filled(max.length, false);
    int matches = 0;
    for (var mi = 0; mi < min.length; mi++) {
      int c1 = min.codeUnitAt(mi);
      for (var xi = math.max(mi - range, 0),
              xn = math.min(mi + range + 1, max.length);
          xi < xn;
          xi++) {
        if (!matchFlags[xi] && c1 == max.codeUnitAt(xi)) {
          matchIndexes[mi] = xi;
          matchFlags[xi] = true;
          matches++;
          break;
        }
      }
    }
    List<int> ms1 = new List<int>(matches);
    List<int> ms2 = new List<int>(matches);
    for (var i = 0, si = 0; i < min.length; i++) {
      if (matchIndexes[i] != -1) {
        ms1[si] = min.codeUnitAt(i);
        si++;
      }
    }
    for (var i = 0, si = 0; i < max.length; i++) {
      if (matchFlags[i]) {
        ms2[si] = max.codeUnitAt(i);
        si++;
      }
    }
    int transpositions = 0;
    for (var mi = 0; mi < ms1.length; mi++) {
      if (ms1[mi] != ms2[mi]) {
        transpositions++;
      }
    }
    int prefix = 0;
    for (var mi = 0; mi < min.length; mi++) {
      if (s1.codeUnitAt(mi) == s2.codeUnitAt(mi)) {
        prefix++;
      } else {
        break;
      }
    }
    return [matches, transpositions ~/ 2, prefix, max.length];
  }
}
