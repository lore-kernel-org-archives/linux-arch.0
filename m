Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33878 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbXDKXlw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 11 Apr 2007 19:41:52 -0400
Subject: Re: + expose-range-checking-functions-from-arch-specific.patch
	added to -mm tree
From: Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20070411112452.6979414c.akpm@linux-foundation.org>
References: <20070410194834.b688ce55.akpm@linux-foundation.org>
	 <200704062127.l36LRMA7019394@shell0.pdx.osdl.net>
	 <6632.1176200270@redhat.com>
	 <1176257950.26372.50.camel@localhost.localdomain>
	 <14926.1176288559@redhat.com>
	 <20070411112452.6979414c.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 09:41:32 +1000
Message-Id: <1176334892.14322.137.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, randy.dunlap@oracle.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2007-04-11 at 11:24 -0700, Andrew Morton wrote:
> I suspect we would benefit from a proper suite of tools for comparing a
> single number against a range, and for comparing ranges.

How about this ambition-reduction patch, instead?

===
range_within() was too ambitious: it started inspiring people.  Remove it.

val_outside() was a terrible name, too.  Try range_over_limit().

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 2f617843ce25 include/asm-generic/range.h
--- a/include/asm-generic/range.h	Thu Apr 12 09:32:53 2007 +1000
+++ b/include/asm-generic/range.h	Thu Apr 12 09:36:20 2007 +1000
@@ -2,18 +2,18 @@
 #define _ASM_GENERIC_RANGE_H
 
 /**
- * val_outside - is a value and length past a limit?
- * @val: the start value
+ * range_over_limit() - is a start and length past a limit?
+ * @start: the start value
  * @len: the length from the start
  * @limit: the first invalid value
  *
- * Like val + len > limit, except with overflow checking.
+ * Like start + len > limit, except with overflow checking.
  */
-static inline bool val_outside(unsigned long val, unsigned long len,
-			       unsigned long limit)
+static inline bool range_over_limit(unsigned long start, unsigned long len,
+				    unsigned long limit)
 
 {
-	return val + len > limit || val + len < val;
+	return start + len > limit || start + len < start;
 }
 
 #endif	/* _ASM_GENERIC_RANGE_H */
diff -r 2f617843ce25 include/asm-i386/range.h
--- a/include/asm-i386/range.h	Thu Apr 12 09:32:53 2007 +1000
+++ b/include/asm-i386/range.h	Thu Apr 12 09:36:37 2007 +1000
@@ -1,14 +1,14 @@
 #ifndef __ASM_RANGE_H
 #define __ASM_RANGE_H
 
-/* Is val + size > limit? This needs 33-bit arithmetic. We have a carry... */
-static inline bool val_outside(unsigned long val, unsigned long len,
-			       unsigned long limit)
+/* Is start + size > limit? This needs 33-bit arithmetic. We have a carry... */
+static inline bool range_over_limit(unsigned long start, unsigned long len,
+				    unsigned long limit)
 {
 	unsigned long flag, roksum;
 	asm("addl %3,%1 ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0"
 		:"=&r" (flag), "=r" (roksum)
-		:"1" (val), "g" (len), "rm" (limit));
+		:"1" (start), "g" (len), "rm" (limit));
 	return flag;
 }
 #endif	/* __ASM_RANGE_H */
diff -r 2f617843ce25 include/asm-i386/uaccess.h
--- a/include/asm-i386/uaccess.h	Thu Apr 12 09:32:53 2007 +1000
+++ b/include/asm-i386/uaccess.h	Thu Apr 12 09:37:07 2007 +1000
@@ -51,10 +51,10 @@ extern struct movsl_mask {
  * This is equivalent to the following test:
  * (u33)addr + (u33)size > (u33)current->addr_limit.seg
  */
-#define __range_ok(addr, size) ({				\
-	__chk_user_ptr(addr);					\
-	val_outside((int)(addr), (size),			\
-		    current_thread_info()->addr_limit.seg);	\
+#define __range_ok(addr, size) ({					\
+	__chk_user_ptr(addr);						\
+	range_over_limit((int)(addr), (size),				\
+			 current_thread_info()->addr_limit.seg);	\
 })
 
 /**
diff -r 2f617843ce25 include/linux/kernel.h
--- a/include/linux/kernel.h	Thu Apr 12 09:32:53 2007 +1000
+++ b/include/linux/kernel.h	Thu Apr 12 09:35:13 2007 +1000
@@ -16,7 +16,6 @@
 #include <linux/log2.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
-#include <asm/range.h>
 
 extern const char linux_banner[];
 extern const char linux_proc_banner[];
@@ -312,26 +311,6 @@ static inline int __attribute__ ((format
 	(void)__tmp; \
 })
 
-/**
- * range_within - is one range within another?
- * @start: the start value
- * @len: the length from the start
- * @base: the first valid value
- * @limit: the first invalid value
- *
- * This is usually used for memory range testing.  The common cases of
- * constant 0 start and constant 0 len cases are optimized out.
- */
-static inline bool range_within(unsigned long start, unsigned long len,
-				unsigned long base, unsigned long limit)
-{
-	if (start < base)
-		return false;
-	if (__builtin_constant_p(len) && len == 0)
-		return start - base <= limit - base;
-	return !val_outside(limit, start, len);
-}
-
 struct sysinfo;
 extern int do_sysinfo(struct sysinfo *info);
 


