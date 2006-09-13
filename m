Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:2447 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751081AbWIMSfl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 14:35:41 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 7/7] Provide ilog2() fallbacks for powerpc [try #3]
Date: Wed, 13 Sep 2006 19:35:36 +0100
Message-Id: <20060913183536.22109.96756.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
References: <20060913183522.22109.10565.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dhowells@redhat.com
List-ID: <linux-arch.vger.kernel.org>

From: David Howells <dhowells@redhat.com>

Provide ilog2() fallbacks for powerpc for 32-bit numbers and 64-bit numbers on
ppc64.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-powerpc/bitops.h |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/include/asm-powerpc/bitops.h b/include/asm-powerpc/bitops.h
index c341063..b6b1169 100644
--- a/include/asm-powerpc/bitops.h
+++ b/include/asm-powerpc/bitops.h
@@ -190,7 +190,8 @@ #include <asm-generic/bitops/non-atomic.
  * Return the zero-based bit position (LE, not IBM bit numbering) of
  * the most significant 1-bit in a double word.
  */
-static __inline__ int __ilog2(unsigned long x)
+static __inline__ __attribute__((const))
+int __ilog2(unsigned long x)
 {
 	int lz;
 
@@ -198,6 +199,26 @@ static __inline__ int __ilog2(unsigned l
 	return BITS_PER_LONG - 1 - lz;
 }
 
+#define ARCH_HAS_ILOG2_U32
+static inline __attribute__((const))
+int __ilog2_u32(u32 n)
+{
+	int bit;
+	asm ("cntlzw %0,%1" : "=r" (bit) : "r" (n));
+	return 31 - bit;
+}
+
+#ifdef __powerpc64__
+#define ARCH_HAS_ILOG2_U64
+static inline __attribute__((const))
+int __ilog2_u64(u32 n)
+{
+	int bit;
+	asm ("cntlzd %0,%1" : "=r" (bit) : "r" (n));
+	return 63 - bit;
+}
+#endif
+
 /*
  * Determines the bit position of the least significant 0 bit in the
  * specified double word. The returned bit position will be
