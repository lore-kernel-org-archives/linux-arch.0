Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:5020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265249AbUHAG1f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 02:27:35 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i716RY115536
	for <linux-arch@vger.kernel.org>; Sat, 31 Jul 2004 23:27:34 -0700
Date: Sat, 31 Jul 2004 23:26:07 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: find_next_bit return type
Message-Id: <20040731232607.11a53e8a.akpm@osdl.org>
In-Reply-To: <20040731232434.7263b50c.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

ppc64:


diff -puN arch/ppc64/kernel/bitops.c~ppc64-bitops-fix arch/ppc64/kernel/bitops.c
--- 25-power4/arch/ppc64/kernel/bitops.c~ppc64-bitops-fix	2004-07-31 21:35:30.042080184 -0700
+++ 25-power4-akpm/arch/ppc64/kernel/bitops.c	2004-07-31 21:36:30.381907136 -0700
@@ -7,15 +7,15 @@
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
 
-unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
+int find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
 	const unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
+	int result = offset & ~63;
 	unsigned long tmp;
 
 	if (offset >= size)
-		return size;
+		return (int)size;
 	size -= result;
 	offset &= 63UL;
 	if (offset) {
@@ -48,15 +48,15 @@ found_middle:
 
 EXPORT_SYMBOL(find_next_zero_bit);
 
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+int find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
 	const unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
+	int result = offset & ~63;
 	unsigned long tmp;
 
 	if (offset >= size)
-		return size;
+		return (int)size;
 	size -= result;
 	offset &= 63UL;
 	if (offset) {
diff -puN include/asm-ppc64/bitops.h~ppc64-bitops-fix include/asm-ppc64/bitops.h
--- 25-power4/include/asm-ppc64/bitops.h~ppc64-bitops-fix	2004-07-31 21:35:30.059077600 -0700
+++ 25-power4-akpm/include/asm-ppc64/bitops.h	2004-07-31 21:36:49.259037376 -0700
@@ -288,11 +288,11 @@ static __inline__ int ffs(int x)
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
-extern unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size, unsigned long offset);
+extern int find_next_zero_bit(const unsigned long *addr, unsigned long size, unsigned long offset);
 #define find_first_zero_bit(addr, size) \
 	find_next_zero_bit((addr), (size), 0)
 
-extern unsigned long find_next_bit(const unsigned long *addr, unsigned long size, unsigned long offset);
+extern int find_next_bit(const unsigned long *addr, unsigned long size, unsigned long offset);
 #define find_first_bit(addr, size) \
 	find_next_bit((addr), (size), 0)
 
_
