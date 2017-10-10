From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tip/core/rcu 08/15] seqlock: Remove now-redundant smp_read_barrier_depends()
Date: Mon,  9 Oct 2017 17:22:42 -0700
Message-ID: <1507594969-8347-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171010001951.GA6476@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-arch.vger.kernel.org

READ_ONCE() now implies smp_read_barrier_depends(), so this patch
removes the now-redundant smp_read_barrier_depends() from
raw_read_seqcount_latch().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 include/linux/seqlock.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index ead97654c4e9..27364347ff68 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -277,9 +277,8 @@ static inline void raw_write_seqcount_barrier(seqcount_t *s)
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
 {
-	int seq = READ_ONCE(s->sequence);
 	/* Pairs with the first smp_wmb() in raw_write_seqcount_latch() */
-	smp_read_barrier_depends();
+	int seq = READ_ONCE(s->sequence); /* ^^^ */
 	return seq;
 }
 
-- 
2.5.2
