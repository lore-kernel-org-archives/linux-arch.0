Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:50116 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbXH1IKD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:10:03 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Sun, 05 Aug 2007 06:28:39 +1000
Message-Id: <20070804202839.13550.11689.sendpatchset@linux.local0.net>
In-Reply-To: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
References: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
Subject: [patch 2/8] alpha: fix bitops
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Documentation/atomic_ops.txt defines these primitives must contain a memory
barrier both before and after their memory operation. This is consistent with
the atomic ops implementation on alpha.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 include/asm-alpha/bitops.h |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-2.6/include/asm-alpha/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-alpha/bitops.h
+++ linux-2.6/include/asm-alpha/bitops.h
@@ -117,6 +117,9 @@ test_and_set_bit(unsigned long nr, volat
 	int *m = ((int *) addr) + (nr >> 5);
 
 	__asm__ __volatile__(
+#ifdef CONFIG_SMP
+	"	mb\n"
+#endif
 	"1:	ldl_l %0,%4\n"
 	"	and %0,%3,%2\n"
 	"	bne %2,2f\n"
@@ -158,6 +161,9 @@ test_and_clear_bit(unsigned long nr, vol
 	int *m = ((int *) addr) + (nr >> 5);
 
 	__asm__ __volatile__(
+#ifdef CONFIG_SMP
+	"	mb\n"
+#endif
 	"1:	ldl_l %0,%4\n"
 	"	and %0,%3,%2\n"
 	"	beq %2,2f\n"
@@ -199,6 +205,9 @@ test_and_change_bit(unsigned long nr, vo
 	int *m = ((int *) addr) + (nr >> 5);
 
 	__asm__ __volatile__(
+#ifdef CONFIG_SMP
+	"	mb\n"
+#endif
 	"1:	ldl_l %0,%4\n"
 	"	and %0,%3,%2\n"
 	"	xor %0,%3,%0\n"
