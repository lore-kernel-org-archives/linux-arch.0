Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:47551 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764636AbXGYLom (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 07:44:42 -0400
Date: Wed, 25 Jul 2007 13:44:41 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch][rfc] ia64: optimised lock bitops
Message-ID: <20070725114441.GN29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

Just for comments because I haven't hard anything from the ia64 guys
about it.

---
 include/asm-ia64/bitops.h |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

Index: linux-2.6/include/asm-ia64/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/bitops.h
+++ linux-2.6/include/asm-ia64/bitops.h
@@ -94,6 +94,38 @@ clear_bit (int nr, volatile void *addr)
 }
 
 /**
+ * clear_bit_unlock - Clears a bit in memory with release
+ * @nr: Bit to clear
+ * @addr: Address to start counting from
+ *
+ * clear_bit_unlock() is atomic and may not be reordered.  It does
+ * contain a memory barrier suitable for unlock type operations.
+ */
+static __inline__ void
+clear_bit_unlock (int nr, volatile void *addr)
+{
+	__u32 mask, old, new;
+	volatile __u32 *m;
+	CMPXCHG_BUGCHECK_DECL
+
+	m = (volatile __u32 *) addr + (nr >> 5);
+	mask = ~(1 << (nr & 31));
+	do {
+		CMPXCHG_BUGCHECK(m);
+		old = *m;
+		new = old & mask;
+	} while (cmpxchg_rel(m, old, new) != old);
+}
+
+/**
+ * __clear_bit_unlock - Non-atomically clear a bit with release
+ *
+ * This is like clear_bit_unlock, but the implementation may use a non-atomic
+ * store (this one uses an atomic, however).
+ */
+#define __clear_bit_unlock clear_bit_unlock
+
+/**
  * __clear_bit - Clears a bit in memory (non-atomic version)
  */
 static __inline__ void
@@ -170,6 +202,15 @@ test_and_set_bit (int nr, volatile void 
 }
 
 /**
+ * test_and_set_bit_lock - Set a bit and return its old value for lock
+ * @nr: Bit to set
+ * @addr: Address to count from
+ *
+ * This is the same as test_and_set_bit on ia64
+ */
+#define test_and_set_bit_lock test_and_set_bit
+
+/**
  * __test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
@@ -371,8 +412,6 @@ hweight64 (unsigned long x)
 #define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
 #define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 
-#include <asm-generic/bitops/lock.h>
-
 #endif /* __KERNEL__ */
 
 #include <asm-generic/bitops/find.h>
