// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:edit_distance/edit_distance.dart';
import 'package:test/test.dart';

void approxEquals(num actual, num expected, [num? tolerance = null]) {
  tolerance ??= (expected / 1e4).abs();
  // Note: use !( <= ) rather than > so we fail on NaNs
  if ((expected - actual).abs() <= tolerance) return;

  fail('Expect.approxEquals(expected:<$expected>, actual:<$actual>, '
      'tolerance:<$tolerance>) fails');
}

void main() {
  group('LevenshteinTest', () {
    test('testDistance', () {
      Levenshtein instance = Levenshtein();
      expect(instance.distance('My string', 'My tring'), 1);
      expect(instance.distance('My string', 'M string2'), 2);
      expect(instance.distance('My string', 'My \$tring'), 1);
    });
  });

  group('DamerauTest', () {
    test('testDistance', () {
      Damerau instance = Damerau();
      expect(instance.distance('ABCDEF', 'ABDCEF'), 1);
      expect(instance.distance('ABCDEF', 'BACDFE'), 2);
      expect(instance.distance('ABCDEF', 'ABCDE'), 1);
    });
  });

  group('LongestCommonSubsequenceTest', () {
    test('testDistance', () {
      LongestCommonSubsequence instance = LongestCommonSubsequence();
      expect(instance.distance('AGCAT', 'GAC'), 4);
      expect(instance.distance('AGCAT', 'AGCT'), 1);
    });
  });

  group('JaroWinklerTest', () {
    test('testDistance', () {
      JaroWinkler instance = JaroWinkler();
      approxEquals(instance.normalizedDistance('My string', 'My tsring'),
          0.025925, 0.000001);
      approxEquals(instance.normalizedDistance('My string', 'My ntrisg'),
          0.103703, 0.000001);
    });
  });

  group('Jaccard', () {
    test('defaults', () {
      Jaccard instance = Jaccard();
      // ab, [bc] vs. ab
      expect(instance.distance('abc', 'ab'), 1);
      expect(instance.normalizedDistance('abc', 'ab'), 0.5);

      // ab, bc, [cd] vs. ab, bc
      expect(instance.distance('abcd', 'abc'), 1);
      approxEquals(instance.normalizedDistance('abcd', 'abc'), 0.33333);

      // ab, bc, [cd], [de] vs. ab, bc
      expect(instance.distance('abcde', 'abc'), 2);
      approxEquals(instance.normalizedDistance('abcde', 'abc'), 0.5);

      // ab, [bc], cd, de  vs.  ab, [bX], [Xc], cd, de
      expect(instance.distance('abcde', 'abXcde'), 3);
      expect(instance.normalizedDistance('abcde', 'abXcde'), 0.5);

      // random typos
      approxEquals(
          instance.normalizedDistance('My string', 'My tsring'), 0.545454);
      approxEquals(
          instance.normalizedDistance('My string', 'My ntrisg'), 0.666666);
    });

    test('N-gram = 3', () {
      Jaccard instance = Jaccard(ngram: 3);
      // [abc], [bcd], cde  vs.  [abX], [bXc], [Xcd], cde
      expect(instance.distance('abcde', 'abXcde'), 5);
      approxEquals(instance.normalizedDistance('abcde', 'abXcde'), 0.83333);
    });

    test('with padding', () {
      Jaccard instance = Jaccard(usePadding: true);
      expect(instance.distance('switch words', 'words switch'), 0);
    });

    test('CombinedJaccard', () {
      CombinedJaccard combined2 = CombinedJaccard(ngram: 2);
      CombinedJaccard combined3 = CombinedJaccard(ngram: 3);
      CombinedJaccard combined4 = CombinedJaccard(ngram: 4);
      CombinedJaccard combined5 = CombinedJaccard(ngram: 5);
      approxEquals(
          combined2.normalizedDistance(
              'The quick brown fox jumps over the lazy dog.',
              'The lazy dog jumps over the quick brown fox.'),
          0.074418);
      approxEquals(
          combined3.normalizedDistance(
              'The quick brown fox jumps over the lazy dog.',
              'The lazy dog jumps over the quick brown fox.'),
          0.11424);
      approxEquals(
          combined4.normalizedDistance(
              'The quick brown fox jumps over the lazy dog.',
              'The lazy dog jumps over the quick brown fox.'),
          0.148127);
      approxEquals(
          combined5.normalizedDistance(
              'The quick brown fox jumps over the lazy dog.',
              'The lazy dog jumps over the quick brown fox.'),
          0.216193);
    });
  });
}
