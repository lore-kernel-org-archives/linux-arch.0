Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54244 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbXH1IKs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:10:48 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Sun, 05 Aug 2007 06:29:23 +1000
Message-Id: <20070804202923.13550.64935.sendpatchset@linux.local0.net>
In-Reply-To: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
References: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
Subject: [patch 7/8] powerpc: lock bitops
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Add non-trivial lock bitops implementation for powerpc.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 include/asm-powerpc/bitops.h |   46 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

Index: linux-2.6/include/asm-powerpc/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/bitops.h
+++ linux-2.6/include/asm-powerpc/bitops.h
@@ -86,6 +86,24 @@ static __inline__ void clear_bit(int nr,
 	: "cc" );
 }
 
+static __inline__ void clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	unsigned long old;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	__asm__ __volatile__(
+	LWSYNC_ON_SMP
+"1:"	PPC_LLARX "%0,0,%3	# clear_bit_unlock\n"
+	"andc	%0,%0,%2\n"
+	PPC405_ERR77(0,%3)
+	PPC_STLCX "%0,0,%3\n"
+	"bne-	1b"
+	: "=&r" (old), "+m" (*p)
+	: "r" (mask), "r" (p)
+	: "cc", "memory");
+}
+
 static __inline__ void change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long old;
@@ -125,6 +143,27 @@ static __inline__ int test_and_set_bit(u
 	return (old & mask) != 0;
 }
 
+static __inline__ int test_and_set_bit_lock(unsigned long nr,
+				       volatile unsigned long *addr)
+{
+	unsigned long old, t;
+	unsigned long mask = BITOP_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
+
+	__asm__ __volatile__(
+"1:"	PPC_LLARX "%0,0,%3		# test_and_set_bit_lock\n"
+	"or	%1,%0,%2 \n"
+	PPC405_ERR77(0,%3)
+	PPC_STLCX "%1,0,%3 \n"
+	"bne-	1b"
+	ISYNC_ON_SMP
+	: "=&r" (old), "=&r" (t)
+	: "r" (mask), "r" (p)
+	: "cc", "memory");
+
+	return (old & mask) != 0;
+}
+
 static __inline__ int test_and_clear_bit(unsigned long nr,
 					 volatile unsigned long *addr)
 {
@@ -185,6 +224,12 @@ static __inline__ void set_bits(unsigned
 
 #include <asm-generic/bitops/non-atomic.h>
 
+static __inline__ void __clear_bit_unlock(int nr, volatile unsigned long *addr)
+{
+	__asm__ __volatile__(LWSYNC_ON_SMP ::: "memory");
+	__clear_bit(nr, addr);
+}
+
 /*
  * Return the zero-based bit position (LE, not IBM bit numbering) of
  * the most significant 1-bit in a double word.
@@ -266,7 +311,6 @@ static __inline__ int fls(unsigned int x
 #include <asm-generic/bitops/fls64.h>
 
 #include <asm-generic/bitops/hweight.h>
-#include <asm-generic/bitops/lock.h>
 
 #define find_first_zero_bit(addr, size) find_next_zero_bit((addr), (size), 0)
 unsigned long find_next_zero_bit(const unsigned long *addr,
