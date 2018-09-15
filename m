From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 23/92] sched/core: Use smp_mb() in
 wake_woken_function()
Date: Sat, 15 Sep 2018 01:30:05 +0000
Message-ID: <20180915012944.179481-23-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "akiyks@gmail.com" <akiyks@gmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "luc.maranget@inria.fr" <luc.maranget@inria.fr>, "npiggin@gmail.com" <npiggin@gmail.com>, "parri.andrea@gmail.com" <parri.andrea@gmail.com>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "will.deacon@arm.com" <will.deacon@arm.com>, Ingo Molnar <mingo@kernel.org>, Sasha Levin <Alexander.Levin@micr>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

[ Upstream commit 76e079fefc8f62bd9b2cd2950814d1ee806e31a5 ]

wake_woken_function() synchronizes with wait_woken() as follows:

  [wait_woken]                       [wake_woken_function]

  entry->flags &=3D ~wq_flag_woken;    condition =3D true;
  smp_mb();                          smp_wmb();
  if (condition)                     wq_entry->flags |=3D wq_flag_woken;
     break;

This commit replaces the above smp_wmb() with an smp_mb() in order to
guarantee that either wait_woken() sees the wait condition being true
or the store to wq_entry->flags in woken_wake_function() follows the
store in wait_woken() in the coherence order (so that the former can
eventually be observed by wait_woken()).

The commit also fixes a comment associated to set_current_state() in
wait_woken(): the comment pairs the barrier in set_current_state() to
the above smp_wmb(), while the actual pairing involves the barrier in
set_current_state() and the barrier executed by the try_to_wake_up()
in wake_woken_function().

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-10-paulmck@linux.vnet.i=
bm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 kernel/sched/wait.c | 47 ++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 928be527477e..a7a2aaa3026a 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -392,35 +392,36 @@ static inline bool is_kthread_should_stop(void)
  *     if (condition)
  *         break;
  *
- *     p->state =3D mode;				condition =3D true;
- *     smp_mb(); // A				smp_wmb(); // C
- *     if (!wq_entry->flags & WQ_FLAG_WOKEN)	wq_entry->flags |=3D WQ_FLAG_=
WOKEN;
- *         schedule()				try_to_wake_up();
- *     p->state =3D TASK_RUNNING;		    ~~~~~~~~~~~~~~~~~~
- *     wq_entry->flags &=3D ~WQ_FLAG_WOKEN;		condition =3D true;
- *     smp_mb() // B				smp_wmb(); // C
- *						wq_entry->flags |=3D WQ_FLAG_WOKEN;
- * }
- * remove_wait_queue(&wq_head, &wait);
+ *     // in wait_woken()			// in woken_wake_function()
  *
+ *     p->state =3D mode;				wq_entry->flags |=3D WQ_FLAG_WOKEN;
+ *     smp_mb(); // A				try_to_wake_up():
+ *     if (!(wq_entry->flags & WQ_FLAG_WOKEN))	   <full barrier>
+ *         schedule()				   if (p->state & mode)
+ *     p->state =3D TASK_RUNNING;			      p->state =3D TASK_RUNNING;
+ *     wq_entry->flags &=3D ~WQ_FLAG_WOKEN;	~~~~~~~~~~~~~~~~~~
+ *     smp_mb(); // B				condition =3D true;
+ * }						smp_mb(); // C
+ * remove_wait_queue(&wq_head, &wait);		wq_entry->flags |=3D WQ_FLAG_WOKEN=
;
  */
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long tim=
eout)
 {
-	set_current_state(mode); /* A */
 	/*
-	 * The above implies an smp_mb(), which matches with the smp_wmb() from
-	 * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
-	 * also observe all state before the wakeup.
+	 * The below executes an smp_mb(), which matches with the full barrier
+	 * executed by the try_to_wake_up() in woken_wake_function() such that
+	 * either we see the store to wq_entry->flags in woken_wake_function()
+	 * or woken_wake_function() sees our store to current->state.
 	 */
+	set_current_state(mode); /* A */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout =3D schedule_timeout(timeout);
 	__set_current_state(TASK_RUNNING);
=20
 	/*
-	 * The below implies an smp_mb(), it too pairs with the smp_wmb() from
-	 * woken_wake_function() such that we must either observe the wait
-	 * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
-	 * an event.
+	 * The below executes an smp_mb(), which matches with the smp_mb() (C)
+	 * in woken_wake_function() such that either we see the wait condition
+	 * being true or the store to wq_entry->flags in woken_wake_function()
+	 * follows ours in the coherence order.
 	 */
 	smp_store_mb(wq_entry->flags, wq_entry->flags & ~WQ_FLAG_WOKEN); /* B */
=20
@@ -430,14 +431,8 @@ EXPORT_SYMBOL(wait_woken);
=20
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, =
int sync, void *key)
 {
-	/*
-	 * Although this function is called under waitqueue lock, LOCK
-	 * doesn't imply write barrier and the users expects write
-	 * barrier semantics on wakeup functions.  The following
-	 * smp_wmb() is equivalent to smp_wmb() in try_to_wake_up()
-	 * and is paired with smp_store_mb() in wait_woken().
-	 */
-	smp_wmb(); /* C */
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
 	wq_entry->flags |=3D WQ_FLAG_WOKEN;
=20
 	return default_wake_function(wq_entry, mode, sync, key);
--=20
2.17.1
