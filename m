Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:57473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760751AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 09/13] ARM: mark cmpxchg and xchg __always_inline for gcc-4.3
Date: Fri, 16 Dec 2016 11:56:30 +0100
Message-ID: <20161216105634.235457-10-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105630.fycrDpcRYG0cTNCwYCd7IWRTMUgV3WICfj1EOtjIz30@z>

With older compiler versions like gcc-4.3 and CONFIG_OPTIMIZE_INLINING,
I run into link errors:

kernel/task_work.o: In function `__cmpxchg':
task_work.c:(.text+0x8c): undefined reference to `__bad_cmpxchg'
kernel/kthread.o: In function `__xchg':
kthread.c:(.text+0x7bc): undefined reference to `__bad_xchg'

This marks the functions in question as __always_inline to force
inlining.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/cmpxchg.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 12215515ba02..218ba0ae90cd 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -24,7 +24,8 @@
 #define swp_is_buggy
 #endif
 
-static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
+static __always_inline unsigned long
+__xchg(unsigned long x, volatile void *ptr, int size)
 {
 	extern void __bad_xchg(volatile void *, int);
 	unsigned long ret;
@@ -152,8 +153,8 @@ extern void __bad_cmpxchg(volatile void *ptr, int size);
  * cmpxchg only support 32-bits operands on ARMv6.
  */
 
-static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
-				      unsigned long new, int size)
+static __always_inline unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	unsigned long oldval, res;
 
@@ -213,9 +214,8 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 				      sizeof(*(ptr)));			\
 })
 
-static inline unsigned long __cmpxchg_local(volatile void *ptr,
-					    unsigned long old,
-					    unsigned long new, int size)
+static __always_inline unsigned long
+__cmpxchg_local(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	unsigned long ret;
 
-- 
2.9.0

