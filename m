Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:2366 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbYCORff (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Mar 2008 13:35:35 -0400
Date: Sat, 15 Mar 2008 18:32:36 +0100
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [3/3] Use __fls for fls64 on 64-bit archs
Message-ID: <20080315173236.GC21659@mailshack.com>
References: <20080315172913.GA21648@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080315172913.GA21648@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm
Message-ID: <20080315173236.yjjiGpDHM884C-zvX52N8b6o1P_8pTC3XDsEl8b5M2E@z>

Use __fls for fls64 on 64-bit archs. The implementation for
64-bit archs is moved from x86_64 to asm-generic.

Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
---
 include/asm-generic/bitops/fls64.h |   22 ++++++++++++++++++++++
 include/asm-x86/bitops_64.h        |   15 ++-------------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/bitops/fls64.h b/include/asm-generic/bitops/fls64.h
index 1b6b17c..86d403f 100644
--- a/include/asm-generic/bitops/fls64.h
+++ b/include/asm-generic/bitops/fls64.h
@@ -3,6 +3,18 @@
 
 #include <asm/types.h>
 
+/**
+ * fls64 - find last set bit in a 64-bit word
+ * @x: the word to search
+ *
+ * This is defined in a similar way as the libc and compiler builtin
+ * ffsll, but returns the position of the most significant set bit.
+ *
+ * fls64(value) returns 0 if value is 0 or the position of the last
+ * set bit if value is nonzero. The last (most significant) bit is
+ * at position 64.
+ */
+#if BITS_PER_LONG == 32
 static inline int fls64(__u64 x)
 {
 	__u32 h = x >> 32;
@@ -10,5 +22,15 @@ static inline int fls64(__u64 x)
 		return fls(h) + 32;
 	return fls(x);
 }
+#elif BITS_PER_LONG == 64
+static inline int fls64(__u64 x)
+{
+	if (x == 0)
+		return 0;
+	return __fls(x) + 1;
+}
+#else
+#error BITS_PER_LONG not 32 or 64
+#endif
 
 #endif /* _ASM_GENERIC_BITOPS_FLS64_H_ */
diff --git a/include/asm-x86/bitops_64.h b/include/asm-x86/bitops_64.h
index aaf1519..1f1f796 100644
--- a/include/asm-x86/bitops_64.h
+++ b/include/asm-x86/bitops_64.h
@@ -112,19 +112,6 @@ static inline int ffs(int x)
 }
 
 /**
- * fls64 - find last bit set in 64 bit word
- * @x: the word to search
- *
- * This is defined the same way as fls.
- */
-static inline int fls64(__u64 x)
-{
-	if (x == 0)
-		return 0;
-	return __fls(x) + 1;
-}
-
-/**
  * fls - find last bit set
  * @x: the word to search
  *
@@ -146,6 +133,8 @@ static inline int fls(int x)
 
 #endif /* __KERNEL__ */
 
+#include <asm-generic/bitops/fls64.h>
+
 #ifdef __KERNEL__
 
 #include <asm-generic/bitops/ext2-non-atomic.h>
