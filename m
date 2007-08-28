Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:50572 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233AbXH1IRb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:17:31 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Tue, 28 Aug 2007 18:15:23 +1000
Message-Id: <20070828081523.13582.48287.sendpatchset@linux.local0.net>
In-Reply-To: <20070828081453.13582.258.sendpatchset@linux.local0.net>
References: <20070828081453.13582.258.sendpatchset@linux.local0.net>
Subject: [patch 3/8] alpha: lock bitops
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Alpha can avoid one mb when acquiring a lock with test_and_set_bit_lock.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 include/asm-alpha/bitops.h |   42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

Index: linux-2.6/include/asm-alpha/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/bitops.h
+++ linux-2.6/include/asm-alpha/bitops.h
@@ -69,6 +69,13 @@ clear_bit(unsigned long nr, volatile voi
 	:"Ir" (1UL << (nr & 31)), "m" (*m));
 }
 
+static inline void
+clear_bit_unlock(unsigned long nr, volatile void * addr)
+{
+	smp_mb();
+	clear_bit(nr, addr);
+}
+
 /*
  * WARNING: non atomic version.
  */
@@ -81,6 +88,13 @@ __clear_bit(unsigned long nr, volatile v
 }
 
 static inline void
+__clear_bit_unlock(unsigned long nr, volatile void * addr)
+{
+	smp_mb();
+	__clear_bit(nr, addr);
+}
+
+static inline void
 change_bit(unsigned long nr, volatile void * addr)
 {
 	unsigned long temp;
@@ -139,6 +153,33 @@ test_and_set_bit(unsigned long nr, volat
 	return oldbit != 0;
 }
 
+static inline int
+test_and_set_bit_lock(unsigned long nr, volatile void *addr)
+{
+	unsigned long oldbit;
+	unsigned long temp;
+	int *m = ((int *) addr) + (nr >> 5);
+
+	__asm__ __volatile__(
+	"1:	ldl_l %0,%4\n"
+	"	and %0,%3,%2\n"
+	"	bne %2,2f\n"
+	"	xor %0,%3,%0\n"
+	"	stl_c %0,%1\n"
+	"	beq %0,3f\n"
+	"2:\n"
+#ifdef CONFIG_SMP
+	"	mb\n"
+#endif
+	".subsection 2\n"
+	"3:	br 1b\n"
+	".previous"
+	:"=&r" (temp), "=m" (*m), "=&r" (oldbit)
+	:"Ir" (1UL << (nr & 31)), "m" (*m) : "memory");
+
+	return oldbit != 0;
+}
+
 /*
  * WARNING: non atomic version.
  */
@@ -376,7 +417,6 @@ static inline unsigned int hweight8(unsi
 #else
 #include <asm-generic/bitops/hweight.h>
 #endif
-#include <asm-generic/bitops/lock.h>
 
 #endif /* __KERNEL__ */
 
