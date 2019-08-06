// Copyright (c) 2016, Kwang Yul Seo. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

abstract class StringDistance {
  int distance(String s1, String s2);
}

abstract class NormalizedStringDistance {
  /// Returns a similarity between 0.0 (exact same) and 1.0 (completely different).
  double normalizedDistance(String s1, String s2);
}
