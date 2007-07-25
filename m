Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44117 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759849AbXGYLe7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Jul 2007 07:34:59 -0400
Date: Wed, 25 Jul 2007 13:34:57 +0200
From: Nick Piggin <npiggin@suse.de>
Subject: [patch 2/7] tasklet_lock use lock bitops
Message-ID: <20070725113457.GH29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>


Convert tasklet lock to new locking bitops.

Signed-off-by: Nick Piggin <npiggin@suse.de>

---
 include/linux/interrupt.h |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/include/linux/interrupt.h
===================================================================
--- linux-2.6.orig/include/linux/interrupt.h
+++ linux-2.6/include/linux/interrupt.h
@@ -334,13 +334,12 @@ enum
 #ifdef CONFIG_SMP
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
-	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
+	return !test_and_set_bit_lock(TASKLET_STATE_RUN, &(t)->state);
 }
 
 static inline void tasklet_unlock(struct tasklet_struct *t)
 {
-	smp_mb__before_clear_bit(); 
-	clear_bit(TASKLET_STATE_RUN, &(t)->state);
+	clear_bit_unlock(TASKLET_STATE_RUN, &(t)->state);
 }
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
