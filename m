Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:47125 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760079AbXGYLim (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 07:38:42 -0400
Date: Wed, 25 Jul 2007 13:38:41 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 4/7] bit_spinlock: use lock bitops
Message-ID: <20070725113841.GJ29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Convert bit_spinlock to new locking bitops.

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
