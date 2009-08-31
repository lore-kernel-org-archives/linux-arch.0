From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 1/9] powerpc: rename __spin_try_lock() and friends
Date: Mon, 31 Aug 2009 14:43:31 +0200
Message-ID: <20090831124415.918799705@de.ibm.com>
References: <20090831124330.014480226@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.17.163]:54710 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbZHaMoR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 31 Aug 2009 08:44:17 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.1/8.13.1) with ESMTP id n7VCiJgw026657
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 12:44:19 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7VCiJPr2740422
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:19 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7VCiG5u010708
	for <linux-arch@vger.kernel.org>; Mon, 31 Aug 2009 14:44:19 +0200
Content-Disposition: inline; filename=powerpc.diff
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <be>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnd Bergmann <arnd@arndb.de>, Nick Piggin <nickpiggin@yahoo.com.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Rename __spin_try_trylock() and friends to arch_spin_try_lock() etc.

Needed to avoid namespace conflicts when the common code function
bodies of _spin_try_lock() etc. are moved to a header file where the
function name would be __spin_try_lock().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6/arch/powerpc/include/asm/spinlock.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/spinlock.h
+++ linux-2.6/arch/powerpc/include/asm/spinlock.h
@@ -54,7 +54,7 @@
  * This returns the old value in the lock, so we succeeded
  * in getting the lock if the return value is 0.
  */
-static inline unsigned long __spin_trylock(raw_spinlock_t *lock)
+static inline unsigned long arch_spin_trylock(raw_spinlock_t *lock)
 {
 	unsigned long tmp, token;
 
@@ -76,7 +76,7 @@ static inline unsigned long __spin_trylo
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 {
 	CLEAR_IO_SYNC;
-	return __spin_trylock(lock) == 0;
+	return arch_spin_trylock(lock) == 0;
 }
 
 /*
@@ -108,7 +108,7 @@ static inline void __raw_spin_lock(raw_s
 {
 	CLEAR_IO_SYNC;
 	while (1) {
-		if (likely(__spin_trylock(lock) == 0))
+		if (likely(arch_spin_trylock(lock) == 0))
 			break;
 		do {
 			HMT_low();
@@ -126,7 +126,7 @@ void __raw_spin_lock_flags(raw_spinlock_
 
 	CLEAR_IO_SYNC;
 	while (1) {
-		if (likely(__spin_trylock(lock) == 0))
+		if (likely(arch_spin_trylock(lock) == 0))
 			break;
 		local_save_flags(flags_dis);
 		local_irq_restore(flags);
@@ -181,7 +181,7 @@ extern void __raw_spin_unlock_wait(raw_s
  * This returns the old value in the lock + 1,
  * so we got a read lock if the return value is > 0.
  */
-static inline long __read_trylock(raw_rwlock_t *rw)
+static inline long arch_read_trylock(raw_rwlock_t *rw)
 {
 	long tmp;
 
@@ -205,7 +205,7 @@ static inline long __read_trylock(raw_rw
  * This returns the old value in the lock,
  * so we got the write lock if the return value is 0.
  */
-static inline long __write_trylock(raw_rwlock_t *rw)
+static inline long arch_write_trylock(raw_rwlock_t *rw)
 {
 	long tmp, token;
 
@@ -228,7 +228,7 @@ static inline long __write_trylock(raw_r
 static inline void __raw_read_lock(raw_rwlock_t *rw)
 {
 	while (1) {
-		if (likely(__read_trylock(rw) > 0))
+		if (likely(arch_read_trylock(rw) > 0))
 			break;
 		do {
 			HMT_low();
@@ -242,7 +242,7 @@ static inline void __raw_read_lock(raw_r
 static inline void __raw_write_lock(raw_rwlock_t *rw)
 {
 	while (1) {
-		if (likely(__write_trylock(rw) == 0))
+		if (likely(arch_write_trylock(rw) == 0))
 			break;
 		do {
 			HMT_low();
@@ -255,12 +255,12 @@ static inline void __raw_write_lock(raw_
 
 static inline int __raw_read_trylock(raw_rwlock_t *rw)
 {
-	return __read_trylock(rw) > 0;
+	return arch_read_trylock(rw) > 0;
 }
 
 static inline int __raw_write_trylock(raw_rwlock_t *rw)
 {
-	return __write_trylock(rw) == 0;
+	return arch_write_trylock(rw) == 0;
 }
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)

-- 
