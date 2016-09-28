// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:edit_distance/edit_distance.dart';
import 'package:test/test.dart';

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
}
