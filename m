From: Justin Chen <jchen@hpdst41.cup.hp.com>
Subject: [PATCH 09/15] bitops: Change the bitmap index from int to unsigned long [mn10300]
Date: Tue, 24 Feb 2009 20:51:00 -0800 (PST)
Message-ID: <200902250451.UAA12851@hpdst41.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:1563 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbZBYEs4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Feb 2009 23:48:56 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: bjorn.helgaas@hp.com, dhowells@redhat.com, justin.chen@hp.com, linux-kernel@vger.kernel.org, yasutake.koichi@jp.panasonic.com

Change the index to unsigned long in all bitops for [mn10300]

Signed-off-by: Justin Chen <justin.chen@hp.com>
Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 arch/mn10300/lib/bitops.c    |    4 ++--
 include/asm-mn10300/bitops.h |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)
diff -Nru a/arch/mn10300/lib/bitops.c b/arch/mn10300/lib/bitops.c
--- a/arch/mn10300/lib/bitops.c	2009-02-13 15:31:30.000000000 -0800
+++ b/arch/mn10300/lib/bitops.c	2009-02-15 18:19:39.783275397 -0800
@@ -15,7 +15,7 @@
 /*
  * try flipping a bit using BSET and BCLR
  */
-void change_bit(int nr, volatile void *addr)
+void change_bit(unsigned long nr, volatile void *addr)
 {
 	if (test_bit(nr, addr))
 		goto try_clear_bit;
@@ -34,7 +34,7 @@
 /*
  * try flipping a bit using BSET and BCLR and returning the old value
  */
-int test_and_change_bit(int nr, volatile void *addr)
+int test_and_change_bit(unsigned long nr, volatile void *addr)
 {
 	if (test_bit(nr, addr))
 		goto try_clear_bit;
diff -Nru a/include/asm-mn10300/bitops.h b/include/asm-mn10300/bitops.h
--- a/include/asm-mn10300/bitops.h	2009-02-13 15:31:30.000000000 -0800
+++ b/include/asm-mn10300/bitops.h	2009-02-15 18:19:39.793041022 -0800
@@ -57,7 +57,7 @@
 #define clear_bit(nr, addr) ___clear_bit((nr), (addr))
 
 
-static inline void __clear_bit(int nr, volatile void *addr)
+static inline void __clear_bit(unsigned long nr, volatile void *addr)
 {
 	unsigned int *a = (unsigned int *) addr;
 	int mask;
@@ -70,7 +70,7 @@
 /*
  * test bit
  */
-static inline int test_bit(int nr, const volatile void *addr)
+static inline int test_bit(unsigned long nr, const volatile void *addr)
 {
 	return 1UL & (((const unsigned int *) addr)[nr >> 5] >> (nr & 31));
 }
@@ -78,7 +78,7 @@
 /*
  * change bit
  */
-static inline void __change_bit(int nr, volatile void *addr)
+static inline void __change_bit(unsigned long nr, volatile void *addr)
 {
 	int	mask;
 	unsigned int *a = (unsigned int *) addr;
@@ -88,7 +88,7 @@
 	*a ^= mask;
 }
 
-extern void change_bit(int nr, volatile void *addr);
+extern void change_bit(unsigned long nr, volatile void *addr);
 
 /*
  * test and set bit
@@ -135,7 +135,7 @@
 /*
  * test and change bit
  */
-static inline int __test_and_change_bit(int nr, volatile void *addr)
+static inline int __test_and_change_bit(unsigned long nr, volatile void *addr)
 {
 	int	mask, retval;
 	unsigned int *a = (unsigned int *)addr;
@@ -148,7 +148,7 @@
 	return retval;
 }
 
-extern int test_and_change_bit(int nr, volatile void *addr);
+extern int test_and_change_bit(unsigned long nr, volatile void *addr);
 
 #include <asm-generic/bitops/lock.h>
 
