Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:64667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265232AbUHAG0o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 02:26:44 -0400
Date: Sat, 31 Jul 2004 23:25:15 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: find_next_bit return type
Message-Id: <20040731232515.1fead83b.akpm@osdl.org>
In-Reply-To: <20040731232434.7263b50c.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

sparc64:


diff -puN arch/sparc64/lib/find_bit.c~sparc64-bitops-fix arch/sparc64/lib/find_bit.c
--- 25-sparc64/arch/sparc64/lib/find_bit.c~sparc64-bitops-fix	2004-07-31 21:25:14.421668712 -0700
+++ 25-sparc64-akpm/arch/sparc64/lib/find_bit.c	2004-07-31 21:25:20.872688008 -0700
@@ -6,11 +6,11 @@
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
+int find_next_bit(const unsigned long *addr, unsigned long size,
 				unsigned long offset)
 {
 	const unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
+	int result = offset & ~63UL;
 	unsigned long tmp;
 
 	if (offset >= size)
@@ -50,14 +50,15 @@ found_middle:
  * on Linus's ALPHA routines, which are pretty portable BTW.
  */
 
-unsigned long find_next_zero_bit(unsigned long *addr, unsigned long size, unsigned long offset)
+int find_next_zero_bit(unsigned long *addr, unsigned long size,
+			unsigned long offset)
 {
 	unsigned long *p = addr + (offset >> 6);
-	unsigned long result = offset & ~63UL;
+	int result = offset & ~63;
 	unsigned long tmp;
 
 	if (offset >= size)
-		return size;
+		return (int)size;
 	size -= result;
 	offset &= 63UL;
 	if (offset) {
diff -puN include/asm-sparc64/bitops.h~sparc64-bitops-fix include/asm-sparc64/bitops.h
--- 25-sparc64/include/asm-sparc64/bitops.h~sparc64-bitops-fix	2004-07-31 21:25:14.422668560 -0700
+++ 25-sparc64-akpm/include/asm-sparc64/bitops.h	2004-07-31 21:25:14.426667952 -0700
@@ -204,8 +204,7 @@ static __inline__ unsigned int hweight8(
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-extern unsigned long find_next_bit(const unsigned long *, unsigned long,
-					unsigned long);
+extern int find_next_bit(const unsigned long *, unsigned long, unsigned long);
 
 /**
  * find_first_bit - find the first set bit in a memory region
@@ -223,7 +222,7 @@ extern unsigned long find_next_bit(const
  * on Linus's ALPHA routines, which are pretty portable BTW.
  */
 
-extern unsigned long find_next_zero_bit(unsigned long *, unsigned long, unsigned long);
+extern int find_next_zero_bit(unsigned long *, unsigned long, unsigned long);
 
 #define find_first_zero_bit(addr, size) \
         find_next_zero_bit((addr), (size), 0)
_
