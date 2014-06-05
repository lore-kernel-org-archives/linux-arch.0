From: Pranith Kumar <pranith@gatech.edu>
Subject: [PATCH 1/1] define generic version of cmpxchg{64} only if not, previously
 defined
Date: Thu, 05 Jun 2014 18:09:48 -0400
Message-ID: <5390EAAC.5070601@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

define generic versions of cmpxchg{64} only if not previously defined.

This makes these definition in-line to other definitions of generic versions


Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/asm-generic/cmpxchg.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/asm-generic/cmpxchg.h b/include/asm-generic/cmpxchg.h
index 811fb1e..7154b79 100644
--- a/include/asm-generic/cmpxchg.h
+++ b/include/asm-generic/cmpxchg.h
@@ -102,7 +102,12 @@ unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
 #endif
 
+#ifndef cmpxchg
 #define cmpxchg(ptr, o, n)	cmpxchg_local((ptr), (o), (n))
+#endif
+
+#ifndef cmpxchg64
 #define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#endif
 
 #endif /* __ASM_GENERIC_CMPXCHG_H */
-- 
1.7.9.5
