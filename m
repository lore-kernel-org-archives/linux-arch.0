From: David Howells <dhowells@redhat.com>
Subject: [PATCH 02/13] Make bitmap functions that return boolean values
 return a bool type
Date: Wed, 29 Apr 2015 20:21:46 +0100
Message-ID: <20150429192146.24909.20484.stgit@warthog.procyon.org.uk>
References: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150429192133.24909.43184.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make bitmap functions that return boolean values return a bool type.  This
permits gcc to make better choices and produce fewer warnings.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/bitmap.h |   30 +++++++++++++++---------------
 lib/bitmap.c           |   32 ++++++++++++++++----------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index ea17cca9e685..46c6cca6fcb4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -87,9 +87,9 @@
  * lib/bitmap.c provides these functions:
  */
 
-extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
-extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
-extern int __bitmap_equal(const unsigned long *bitmap1,
+extern bool __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
+extern bool __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
+extern bool __bitmap_equal(const unsigned long *bitmap1,
 			  const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_complement(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits);
@@ -97,17 +97,17 @@ extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits);
 extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 				unsigned int shift, unsigned int nbits);
-extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int nbits);
+extern bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
 extern void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+extern bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_intersects(const unsigned long *bitmap1,
+extern bool __bitmap_intersects(const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
-extern int __bitmap_subset(const unsigned long *bitmap1,
+extern bool __bitmap_subset(const unsigned long *bitmap1,
 			const unsigned long *bitmap2, unsigned int nbits);
 extern int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 
@@ -209,7 +209,7 @@ static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 	}
 }
 
-static inline int bitmap_and(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -235,7 +235,7 @@ static inline void bitmap_xor(unsigned long *dst, const unsigned long *src1,
 		__bitmap_xor(dst, src1, src2, nbits);
 }
 
-static inline int bitmap_andnot(unsigned long *dst, const unsigned long *src1,
+static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -252,7 +252,7 @@ static inline void bitmap_complement(unsigned long *dst, const unsigned long *sr
 		__bitmap_complement(dst, src, nbits);
 }
 
-static inline int bitmap_equal(const unsigned long *src1,
+static inline bool bitmap_equal(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -261,7 +261,7 @@ static inline int bitmap_equal(const unsigned long *src1,
 		return __bitmap_equal(src1, src2, nbits);
 }
 
-static inline int bitmap_intersects(const unsigned long *src1,
+static inline bool bitmap_intersects(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -270,7 +270,7 @@ static inline int bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
-static inline int bitmap_subset(const unsigned long *src1,
+static inline bool bitmap_subset(const unsigned long *src1,
 			const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
@@ -279,7 +279,7 @@ static inline int bitmap_subset(const unsigned long *src1,
 		return __bitmap_subset(src1, src2, nbits);
 }
 
-static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
+static inline bool bitmap_empty(const unsigned long *src, unsigned nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (*src & BITMAP_LAST_WORD_MASK(nbits));
@@ -287,7 +287,7 @@ static inline int bitmap_empty(const unsigned long *src, unsigned nbits)
 	return find_first_bit(src, nbits) == nbits;
 }
 
-static inline int bitmap_full(const unsigned long *src, unsigned int nbits)
+static inline bool bitmap_full(const unsigned long *src, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		return ! (~(*src) & BITMAP_LAST_WORD_MASK(nbits));
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 64c0926f5dd8..663a82df8f38 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -42,19 +42,19 @@
  * for the best explanations of this ordering.
  */
 
-int __bitmap_equal(const unsigned long *bitmap1,
+bool __bitmap_equal(const unsigned long *bitmap1,
 		const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] ^ bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
+			return false;
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_equal);
 
@@ -150,7 +150,7 @@ void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
 }
 EXPORT_SYMBOL(__bitmap_shift_left);
 
-int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
@@ -188,7 +188,7 @@ void __bitmap_xor(unsigned long *dst, const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_xor);
 
-int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
+bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 				const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k;
@@ -204,33 +204,33 @@ int __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_andnot);
 
-int __bitmap_intersects(const unsigned long *bitmap1,
-			const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_intersects(const unsigned long *bitmap1,
+			 const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
-			return 1;
+			return true;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 1;
-	return 0;
+			return true;
+	return false;
 }
 EXPORT_SYMBOL(__bitmap_intersects);
 
-int __bitmap_subset(const unsigned long *bitmap1,
-		    const unsigned long *bitmap2, unsigned int bits)
+bool __bitmap_subset(const unsigned long *bitmap1,
+		     const unsigned long *bitmap2, unsigned int bits)
 {
 	unsigned int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & ~bitmap2[k])
-			return 0;
+			return false;
 
 	if (bits % BITS_PER_LONG)
 		if ((bitmap1[k] & ~bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
-			return 0;
-	return 1;
+			return false;
+	return true;
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
