From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 4/4] remove dma64_addr_t
Date: Tue, 12 Oct 2010 12:13:15 +0900
Message-ID: <1286853195-32202-5-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:35334 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752121Ab0JLDW5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Oct 2010 23:22:57 -0400
In-Reply-To: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org

There is no user now.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/alpha/include/asm/types.h   |   11 -----------
 arch/arm/include/asm/types.h     |    6 ------
 arch/cris/include/asm/types.h    |    6 ------
 arch/m32r/include/asm/types.h    |    6 ------
 arch/m68k/include/asm/types.h    |    6 ------
 arch/mips/include/asm/types.h    |    2 --
 arch/parisc/include/asm/types.h  |   13 -------------
 arch/powerpc/include/asm/types.h |    2 --
 arch/s390/include/asm/types.h    |    2 --
 arch/sparc/include/asm/types.h   |   18 ------------------
 arch/x86/include/asm/types.h     |    8 --------
 11 files changed, 0 insertions(+), 80 deletions(-)

diff --git a/arch/alpha/include/asm/types.h b/arch/alpha/include/asm/types.h
index e46e503..8815443 100644
--- a/arch/alpha/include/asm/types.h
+++ b/arch/alpha/include/asm/types.h
@@ -20,15 +20,4 @@
 typedef unsigned int umode_t;
 
 #endif /* __ASSEMBLY__ */
-
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-
-typedef u64 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-#endif /* __KERNEL__ */
 #endif /* _ALPHA_TYPES_H */
diff --git a/arch/arm/include/asm/types.h b/arch/arm/include/asm/types.h
index c684e37..48192ac 100644
--- a/arch/arm/include/asm/types.h
+++ b/arch/arm/include/asm/types.h
@@ -16,12 +16,6 @@ typedef unsigned short umode_t;
 
 #define BITS_PER_LONG 32
 
-#ifndef __ASSEMBLY__
-
-typedef u32 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/arch/cris/include/asm/types.h b/arch/cris/include/asm/types.h
index 4405508..551a12c 100644
--- a/arch/cris/include/asm/types.h
+++ b/arch/cris/include/asm/types.h
@@ -16,12 +16,6 @@ typedef unsigned short umode_t;
 
 #define BITS_PER_LONG 32
 
-#ifndef __ASSEMBLY__
-
-typedef u32 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 
 #endif
diff --git a/arch/m32r/include/asm/types.h b/arch/m32r/include/asm/types.h
index fd84b48..bd00355 100644
--- a/arch/m32r/include/asm/types.h
+++ b/arch/m32r/include/asm/types.h
@@ -16,12 +16,6 @@ typedef unsigned short umode_t;
 
 #define BITS_PER_LONG 32
 
-#ifndef __ASSEMBLY__
-
-typedef u64 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_M32R_TYPES_H */
diff --git a/arch/m68k/include/asm/types.h b/arch/m68k/include/asm/types.h
index 10ad92f..b17fd11 100644
--- a/arch/m68k/include/asm/types.h
+++ b/arch/m68k/include/asm/types.h
@@ -23,12 +23,6 @@ typedef unsigned short umode_t;
 
 #define BITS_PER_LONG 32
 
-#ifndef __ASSEMBLY__
-
-typedef u32 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* __KERNEL__ */
 
 #endif /* _M68K_TYPES_H */
diff --git a/arch/mips/include/asm/types.h b/arch/mips/include/asm/types.h
index 9520dc8..533812b 100644
--- a/arch/mips/include/asm/types.h
+++ b/arch/mips/include/asm/types.h
@@ -33,8 +33,6 @@ typedef unsigned short umode_t;
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-typedef u64 dma64_addr_t;
-
 /*
  * Don't use phys_t.  You've been warned.
  */
diff --git a/arch/parisc/include/asm/types.h b/arch/parisc/include/asm/types.h
index bc164dd..80e415c 100644
--- a/arch/parisc/include/asm/types.h
+++ b/arch/parisc/include/asm/types.h
@@ -9,17 +9,4 @@ typedef unsigned short umode_t;
 
 #endif /* __ASSEMBLY__ */
 
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-typedef u64 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
 #endif
diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
index e16a6b2..8947b98 100644
--- a/arch/powerpc/include/asm/types.h
+++ b/arch/powerpc/include/asm/types.h
@@ -44,8 +44,6 @@ typedef struct {
 
 typedef __vector128 vector128;
 
-typedef u64 dma64_addr_t;
-
 typedef struct {
 	unsigned long entry;
 	unsigned long toc;
diff --git a/arch/s390/include/asm/types.h b/arch/s390/include/asm/types.h
index f7f6ae6..eeb52cc 100644
--- a/arch/s390/include/asm/types.h
+++ b/arch/s390/include/asm/types.h
@@ -30,8 +30,6 @@ typedef __signed__ long saddr_t;
 
 #ifndef __ASSEMBLY__
 
-typedef u64 dma64_addr_t;
-
 #ifndef __s390x__
 typedef union {
 	unsigned long long pair;
diff --git a/arch/sparc/include/asm/types.h b/arch/sparc/include/asm/types.h
index f02d330..91e5a03 100644
--- a/arch/sparc/include/asm/types.h
+++ b/arch/sparc/include/asm/types.h
@@ -18,24 +18,6 @@ typedef unsigned short umode_t;
 
 #endif /* __ASSEMBLY__ */
 
-#ifdef __KERNEL__
-
-#ifndef __ASSEMBLY__
-
-#if defined(__arch64__)
-
-/*** SPARC 64 bit ***/
-typedef u64 dma64_addr_t;
-#else
-/*** SPARC 32 bit ***/
-typedef u32 dma64_addr_t;
-
-#endif /* defined(__arch64__) */
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
-
 #endif /* defined(__sparc__) */
 
 #endif /* defined(_SPARC_TYPES_H) */
diff --git a/arch/x86/include/asm/types.h b/arch/x86/include/asm/types.h
index 8810205..8e8c23f 100644
--- a/arch/x86/include/asm/types.h
+++ b/arch/x86/include/asm/types.h
@@ -3,12 +3,4 @@
 
 #include <asm-generic/types.h>
 
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-
-typedef u64 dma64_addr_t;
-
-#endif /* __ASSEMBLY__ */
-#endif /* __KERNEL__ */
-
 #endif /* _ASM_X86_TYPES_H */
-- 
1.7.1
