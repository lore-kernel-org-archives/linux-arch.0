From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 1/4] asm-generic: cmpxchg: implement dummy cmpxchg64_relaxed operation
Date: Thu, 26 Sep 2013 16:13:28 +0100
Message-ID: <1380208411-31403-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tony.luck@intel.com, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

cmpxchg64_relaxed can be used to provide barrier-less semantics for a
64-bit cmpxchg operation in cases where the strong memory ordering is
not required.

This patch implements a dummy implementation for asm-generic, falling
back to the usual cmpxchg64 code.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/cmpxchg.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 811fb1e..298b9d4 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -102,7 +102,8 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
-#define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg(ptr, o, n)		cmpxchg_local((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n)		cmpxchg64_local((ptr), (o), (n))
+#define cmpxchg64_relaxed(ptr, o, n)	cmpxchg64((ptr), (o), (n))
 
 #endif /* __ASM_GENERIC_CMPXCHG_H */
-- 
1.8.2.2
