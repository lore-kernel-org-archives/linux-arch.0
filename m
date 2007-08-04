Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54206 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416AbXH1IK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:10:29 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Sun, 05 Aug 2007 06:29:05 +1000
Message-Id: <20070804202905.13550.90814.sendpatchset@linux.local0.net>
In-Reply-To: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
References: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
Subject: [patch 5/8] mips: fix bitops
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Documentation/atomic_ops.txt defines these primitives must contain a memory
barrier both before and after their memory operation. This is consistent with
the atomic ops implementation on mips.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 include/asm-mips/bitops.h |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/include/asm-mips/bitops.h
===================================================================
--- linux-2.6.orig/include/asm-mips/bitops.h
+++ linux-2.6/include/asm-mips/bitops.h
@@ -240,6 +240,8 @@ static inline int test_and_set_bit(unsig
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
+	smp_llsc_mb();
+
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -308,6 +310,8 @@ static inline int test_and_clear_bit(uns
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
+	smp_llsc_mb();
+
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
@@ -396,6 +400,8 @@ static inline int test_and_change_bit(un
 	unsigned short bit = nr & SZLONG_MASK;
 	unsigned long res;
 
+	smp_llsc_mb();
+
 	if (cpu_has_llsc && R10000_LLSC_WAR) {
 		unsigned long *m = ((unsigned long *) addr) + (nr >> SZLONG_LOG);
 		unsigned long temp;
