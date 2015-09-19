From: Marek Vasut <marex@denx.de>
Subject: [PATCH] asm-generic: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations
Date: Sat, 19 Sep 2015 06:42:21 +0200
Message-ID: <1442637741-10807-1-git-send-email-marex@denx.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47265 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbISEmQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Sep 2015 00:42:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: lftan@altera.com, arnd@arndb.de, linux-arch@vger.kernel.org, Marek Vasut <marex@denx.de>, Russell King <rmk+kernel@arm.linux.org.uk>

This change is similar to e001bbae7147b111fe1aa42beaf835635f3c016e
ARM: cmpxchg: avoid warnings from macro-ized cmpxchg() implementations

A recent change in kernel/acct.c added a new warning for many
configurations using generic __xchg() implementation:

In file included from ./arch/nios2/include/asm/cmpxchg.h:12:0,
                 from include/asm-generic/atomic.h:18,
                 from arch/nios2/include/generated/asm/atomic.h:1,
                 from include/linux/atomic.h:4,
                 from include/linux/spinlock.h:406,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:5,
                 from include/linux/mm.h:9,
                 from kernel/acct.c:46:
kernel/acct.c: In function 'acct_pin_kill':
include/asm-generic/cmpxchg.h:94:3: warning: value computed is not used [-Wunused-value]
  ((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
   ^
include/asm-generic/cmpxchg.h:102:28: note: in expansion of macro 'cmpxchg_local'
 #define cmpxchg(ptr, o, n) cmpxchg_local((ptr), (o), (n))
                            ^
kernel/acct.c:177:2: note: in expansion of macro 'cmpxchg'
  cmpxchg(&acct->ns->bacct, pin, NULL);
  ^

The code is in fact correct, it's just a cmpxchg() call that
intentionally ignores the result, and no other code does that.  The
warning does not show up on x86 because of the way that its cmpxchg()
macro is written. This changes the asm-ggeneric implementation to use
a similar construct with a compound expression instead of a typecast,
which causes the compiler to not complain about an unused result.

Fix the other macros in this file in a similar way, and place them
just below their function implementations.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/asm-generic/cmpxchg.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 3766ab3..e5f9080 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -79,8 +79,10 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 	}
 }
 
-#define xchg(ptr, x) \
-	((__typeof__(*(ptr))) __xchg((unsigned long)(x), (ptr), sizeof(*(ptr))))
+#define xchg(ptr, x) ({							\
+	((__typeof__(*(ptr)))						\
+		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr))));	\
+})
 
 #endif /* xchg */
 
@@ -90,9 +92,10 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #include <asm-generic/cmpxchg-local.h>
 
 #ifndef cmpxchg_local
-#define cmpxchg_local(ptr, o, n)				  	       \
+#define cmpxchg_local(ptr, o, n) ({					       \
 	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
-			(unsigned long)(n), sizeof(*(ptr))))
+			(unsigned long)(n), sizeof(*(ptr))));		       \
+})
 #endif
 
 #ifndef cmpxchg64_local
-- 
2.1.4
