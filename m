From: Clement Courbet <courbet@google.com>
Subject: [PATCH] lib: optimize cpumask_next_and()
Date: Mon, 23 Oct 2017 10:05:10 +0200
Message-ID: <20171023080510.30550-1-courbet@google.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:51996 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdJWIG1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Oct 2017 04:06:27 -0400
Received: by mail-wr0-f194.google.com with SMTP id j15so4217825wre.8
        for <linux-arch@vger.kernel.org>; Mon, 23 Oct 2017 01:06:26 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <mawilcox@microsoft.com>
Cc: Clement Courbet <courbet@google.com>, Yury Norov <ynorov@caviumnetworks.com>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

We've measured that we spend ~0.6% of sys cpu time in cpumask_next_and().
It's essentially a joined iteration in search for a non-zero bit, which
is currently implemented as a lookup join (find a nonzero bit on the
lhs, lookup the rhs to see if it's set there).

Implement a direct join (find a nonzero bit on the incrementally built
join). Direct benchmarking shows that it's 1.17x to 14x faster with a
geometric mean of 2.1 on 32 CPUs. No impact on memory usage.

Approximate benchmark code:

```
  unsigned long src1p[nr_cpumask_longs] = {pattern1};
  unsigned long src2p[nr_cpumask_longs] = {pattern2};
  for (/*a bunch of repetitions*/) {
    for (int n = -1; n <= nr_cpu_ids; ++n) {
      asm volatile("" : "+rm"(src1p)); // prevent any optimization
      asm volatile("" : "+rm"(src2p));
      unsigned long result = cpumask_next_and(n, src1p, src2p);
      asm volatile("" : "+rm"(result));
    }
  }
```

Results:
pattern1    pattern2     time_before/time_after
0x0000ffff  0x0000ffff   1.65
0x0000ffff  0x00005555   2.24
0x0000ffff  0x00001111   2.94
0x0000ffff  0x00000000   14.0
0x00005555  0x0000ffff   1.67
0x00005555  0x00005555   1.71
0x00005555  0x00001111   1.90
0x00005555  0x00000000   6.58
0x00001111  0x0000ffff   1.46
0x00001111  0x00005555   1.49
0x00001111  0x00001111   1.45
0x00001111  0x00000000   3.10
0x00000000  0x0000ffff   1.18
0x00000000  0x00005555   1.18
0x00000000  0x00001111   1.17
0x00000000  0x00000000   1.25
-----------------------------
               geo.mean  2.06

Signed-off-by: Clement Courbet <courbet@google.com>
---
 include/asm-generic/bitops/find.h       | 16 ++++++++++++++++
 include/linux/bitmap.h                  |  2 ++
 lib/cpumask.c                           |  9 +++++----
 lib/find_bit.c                          | 34 +++++++++++++++++++++++++++++++++
 tools/include/asm-generic/bitops/find.h | 16 ++++++++++++++++
 5 files changed, 73 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
index 998d4d544f18..130962f3a264 100644
--- a/include/asm-generic/bitops/find.h
+++ b/include/asm-generic/bitops/find.h
@@ -15,6 +15,22 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
 		size, unsigned long offset);
 #endif
 
+#ifndef find_next_and_bit
+/**
+ * find_next_and_bit - find the next set bit in both memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_next_and_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset);
+#endif
+
 #ifndef find_next_zero_bit
 /**
  * find_next_zero_bit - find the next cleared bit in a memory region
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 700cf5f67118..b4606bfda52f 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -77,6 +77,8 @@
  * find_first_bit(addr, nbits)		Position first set bit in *addr
  * find_next_zero_bit(addr, nbits, bit)	Position next zero bit in *addr >= bit
  * find_next_bit(addr, nbits, bit)	Position next set bit in *addr >= bit
+ * find_next_and_bit(addr1, addr2, nbits, bit)	Same as find_first_bit, but in
+ *						(*addr1 & *addr2)
  */
 
 /*
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 8b1a1bd77539..5602223837fa 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -32,10 +32,11 @@ EXPORT_SYMBOL(cpumask_next);
 int cpumask_next_and(int n, const struct cpumask *src1p,
 		     const struct cpumask *src2p)
 {
-	while ((n = cpumask_next(n, src1p)) < nr_cpu_ids)
-		if (cpumask_test_cpu(n, src2p))
-			break;
-	return n;
+	/* -1 is a legal arg here. */
+	if (n != -1)
+		cpumask_check(n);
+	return find_next_and_bit(cpumask_bits(src1p), cpumask_bits(src2p),
+		nr_cpumask_bits, n + 1);
 }
 EXPORT_SYMBOL(cpumask_next_and);
 
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 6ed74f78380c..83ea8b97ed3e 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -75,6 +75,40 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 EXPORT_SYMBOL(find_next_zero_bit);
 #endif
 
+#if !defined(find_next_and_bit)
+
+/*
+ * Find the next set bit in a memory region.
+ */
+unsigned long find_next_and_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long nbits,
+		unsigned long start)
+{
+	unsigned long tmp;
+
+	if (!nbits || start >= nbits)
+		return nbits;
+
+	tmp = addr1[start / BITS_PER_LONG] & addr2[start / BITS_PER_LONG];
+
+	/* Handle 1st word. */
+	tmp &= BITMAP_FIRST_WORD_MASK(start);
+	start = round_down(start, BITS_PER_LONG);
+
+	while (!tmp) {
+		start += BITS_PER_LONG;
+		if (start >= nbits)
+			return nbits;
+
+		tmp = addr1[start / BITS_PER_LONG] &
+			addr2[start / BITS_PER_LONG];
+	}
+
+	return min(start + __ffs(tmp), nbits);
+}
+EXPORT_SYMBOL(find_next_and_bit);
+#endif
+
 #ifndef find_first_bit
 /*
  * Find the first set bit in a memory region.
diff --git a/tools/include/asm-generic/bitops/find.h b/tools/include/asm-generic/bitops/find.h
index 5538ecdc964a..435c7d002f33 100644
--- a/tools/include/asm-generic/bitops/find.h
+++ b/tools/include/asm-generic/bitops/find.h
@@ -15,6 +15,22 @@ extern unsigned long find_next_bit(const unsigned long *addr, unsigned long
 		size, unsigned long offset);
 #endif
 
+#ifndef find_next_and_bit
+/**
+ * find_next_and_bit - find the next set bit in both memory regions
+ * @addr1: The first address to base the search on
+ * @addr2: The second address to base the search on
+ * @offset: The bitnumber to start searching at
+ * @size: The bitmap size in bits
+ *
+ * Returns the bit number for the next set bit
+ * If no bits are set, returns @size.
+ */
+extern unsigned long find_next_and_bit(const unsigned long *addr1,
+		const unsigned long *addr2, unsigned long size,
+		unsigned long offset);
+#endif
+
 #ifndef find_next_zero_bit
 
 /**
-- 
2.15.0.rc0.271.g36b669edcc-goog
