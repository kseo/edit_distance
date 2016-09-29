// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:edit_distance/edit_distance.dart';
import 'package:test/test.dart';

void approxEquals(num actual, num expected, [num tolerance = null]) {
  if (tolerance == null) {
    tolerance = (expected / 1e4).abs();
  }
  // Note: use !( <= ) rather than > so we fail on NaNs
  if ((expected - actual).abs() <= tolerance) return;

  fail('Expect.approxEquals(expected:<$expected>, actual:<$actual>, '
      'tolerance:<$tolerance>) fails');
}

void main() {
  group('LevenshteinTest', () {
    test('testDistance', () {
      Levenshtein instance = new Levenshtein();
      expect(instance.distance('My string', 'My tring'), 1);
      expect(instance.distance('My string', 'M string2'), 2);
      expect(instance.distance('My string', 'My \$tring'), 1);
    });
  });

  group('DamerauTest', () {
    test('testDistance', () {
      Damerau instance = new Damerau();
      expect(instance.distance("ABCDEF", "ABDCEF"), 1);
      expect(instance.distance("ABCDEF", "BACDFE"), 2);
      expect(instance.distance("ABCDEF", "ABCDE"), 1);
    });
  });

  group('LongestCommonSubsequenceTest', () {
    test('testDistance', () {
      LongestCommonSubsequence instance = new LongestCommonSubsequence();
      expect(instance.distance("AGCAT", "GAC"), 4);
      expect(instance.distance("AGCAT", "AGCT"), 1);
    });
  });

  group('JaroWinklerTest', () {
    test('testDistance', () {
      JaroWinkler instance = new JaroWinkler();
      approxEquals(instance.normalizedDistance("My string", "My tsring"),
          0.025925, 0.000001);
      approxEquals(instance.normalizedDistance("My string", "My ntrisg"),
          0.103703, 0.000001);
    });
  });
}
