Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:2716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265234AbUHAG1L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 02:27:11 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i716RA115499
	for <linux-arch@vger.kernel.org>; Sat, 31 Jul 2004 23:27:10 -0700
Date: Sat, 31 Jul 2004 23:25:43 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: find_next_bit return type
Message-Id: <20040731232543.39b37766.akpm@osdl.org>
In-Reply-To: <20040731232434.7263b50c.akpm@osdl.org>
References: <20040731232434.7263b50c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

x86_64:


diff -puN include/asm-x86_64/bitops.h~x86_64-bitops-fix include/asm-x86_64/bitops.h
--- 25/include/asm-x86_64/bitops.h~x86_64-bitops-fix	2004-07-31 22:30:52.417209120 -0700
+++ 25-akpm/include/asm-x86_64/bitops.h	2004-07-31 22:31:28.898663096 -0700
@@ -256,8 +256,8 @@ static __inline__ int variable_test_bit(
 
 extern long find_first_zero_bit(const unsigned long * addr, unsigned long size);
 extern long find_next_zero_bit (const unsigned long * addr, long size, long offset);
-extern long find_first_bit(const unsigned long * addr, unsigned long size);
-extern long find_next_bit(const unsigned long * addr, long size, long offset);
+extern int find_first_bit(const unsigned long * addr, unsigned long size);
+extern int find_next_bit(const unsigned long * addr, long size, long offset);
 
 /* 
  * Find string of zero bits in a bitmap. -1 when not found.
diff -puN arch/x86_64/lib/bitops.c~x86_64-bitops-fix arch/x86_64/lib/bitops.c
--- 25/arch/x86_64/lib/bitops.c~x86_64-bitops-fix	2004-07-31 22:31:41.598732392 -0700
+++ 25-akpm/arch/x86_64/lib/bitops.c	2004-07-31 22:32:12.100095480 -0700
@@ -93,7 +93,7 @@ __find_first_bit(const unsigned long * a
  * Returns the bit-number of the first set bit, not the number of the byte
  * containing a bit.
  */
-long find_first_bit(const unsigned long * addr, unsigned long size)
+int find_first_bit(const unsigned long * addr, unsigned long size)
 {
 	return __find_first_bit(addr,size);
 }
@@ -104,7 +104,7 @@ long find_first_bit(const unsigned long 
  * @offset: The bitnumber to start searching at
  * @size: The maximum size to search
  */
-long find_next_bit(const unsigned long * addr, long size, long offset)
+int find_next_bit(const unsigned long * addr, long size, long offset)
 {
 	const unsigned long * p = addr + (offset >> 6);
 	unsigned long set = 0, bit = offset & 63, res;
_
