Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54254 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbXH1IK4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 28 Aug 2007 04:10:56 -0400
From: Nick Piggin <npiggin@suse.de>
Date: Sun, 05 Aug 2007 06:29:32 +1000
Message-Id: <20070804202932.13550.80385.sendpatchset@linux.local0.net>
In-Reply-To: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
References: <20070804202820.13550.67814.sendpatchset@linux.local0.net>
Subject: [patch 8/8] bit_spin_lock: use lock bitops
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Linux Arch <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Convert bit_spin_lock to new locking bitops. Slub can use the non-atomic store
version to clear (Christoph?)

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 include/linux/bit_spinlock.h |   26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

Index: linux-2.6/include/linux/bit_spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/bit_spinlock.h
+++ linux-2.6/include/linux/bit_spinlock.h
@@ -18,7 +18,7 @@ static inline void bit_spin_lock(int bit
 	 */
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (test_and_set_bit(bitnum, addr)) {
+	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
 		while (test_bit(bitnum, addr)) {
 			preempt_enable();
 			cpu_relax();
@@ -36,7 +36,7 @@ static inline int bit_spin_trylock(int b
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	if (test_and_set_bit(bitnum, addr)) {
+	if (unlikely(test_and_set_bit_lock(bitnum, addr))) {
 		preempt_enable();
 		return 0;
 	}
@@ -50,10 +50,28 @@ static inline int bit_spin_trylock(int b
  */
 static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
+#ifdef CONFIG_DEBUG_SPINLOCK
+	BUG_ON(!test_bit(bitnum, addr));
+#endif
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	clear_bit_unlock(bitnum, addr);
+#endif
+	preempt_enable();
+	__release(bitlock);
+}
+
+/*
+ *  bit-based spin_unlock()
+ *  non-atomic version, which can be used eg. if the bit lock itself is
+ *  protecting the rest of the flags in the word.
+ */
+static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+{
+#ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
-	smp_mb__before_clear_bit();
-	clear_bit(bitnum, addr);
+#endif
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+	__clear_bit_unlock(bitnum, addr);
 #endif
 	preempt_enable();
 	__release(bitlock);
