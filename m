Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:58080 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfGKWMp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 18:12:45 -0400
From: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH] padata: use smp_mb in padata_reorder to avoid orphaned padata jobs
Date: Thu, 11 Jul 2019 18:12:05 -0400
Message-ID: <20190711221205.29889-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: steffen.klassert@secunet.com
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190711221205.UYeHO017xwCccxmFceVqTFCVP6xzDroWeKJhDbeAgKQ@z>

Testing padata with the tcrypt module on a 5.2 kernel...

    # modprobe tcrypt alg="pcrypt(rfc4106(gcm(aes)))" type=3
    # modprobe tcrypt mode=211 sec=1

...produces this splat:

    INFO: task modprobe:10075 blocked for more than 120 seconds.
          Not tainted 5.2.0-base+ #16
    modprobe        D    0 10075  10064 0x80004080
    Call Trace:
     ? __schedule+0x4dd/0x610
     ? ring_buffer_unlock_commit+0x23/0x100
     schedule+0x6c/0x90
     schedule_timeout+0x3b/0x320
     ? trace_buffer_unlock_commit_regs+0x4f/0x1f0
     wait_for_common+0x160/0x1a0
     ? wake_up_q+0x80/0x80
     { crypto_wait_req }             # entries in braces added by hand
     { do_one_aead_op }
     { test_aead_jiffies }
     test_aead_speed.constprop.17+0x681/0xf30 [tcrypt]
     do_test+0x4053/0x6a2b [tcrypt]
     ? 0xffffffffa00f4000
     tcrypt_mod_init+0x50/0x1000 [tcrypt]
     ...

The second modprobe command never finishes because in padata_reorder,
CPU0's load of reorder_objects is executed before the unlocking store in
spin_unlock_bh(pd->lock), causing CPU0 to miss CPU1's increment:

CPU0                                 CPU1

padata_reorder                       padata_do_serial
  LOAD reorder_objects  // 0
                                       INC reorder_objects  // 1
                                       padata_reorder
                                         TRYLOCK pd->lock   // failed
  UNLOCK pd->lock

CPU0 deletes the timer before returning from padata_reorder and since no
other job is submitted to padata, modprobe waits indefinitely.

Add a full barrier to prevent this scenario.  The hang was happening
about once every three runs, but now the test has finished successfully
fifty times in a row.

Fixes: 16295bec6398 ("padata: Generic parallelization/serialization interface")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

memory-barriers.txt says that a full barrier pairs with a release barrier, but
I'd appreciate a look from someone more familiar with barriers.  Thanks.

 kernel/padata.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/padata.c b/kernel/padata.c
index 2d2fddbb7a4c..9cffd4c303cb 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -267,7 +267,12 @@ static void padata_reorder(struct parallel_data *pd)
 	 * The next object that needs serialization might have arrived to
 	 * the reorder queues in the meantime, we will be called again
 	 * from the timer function if no one else cares for it.
+	 *
+	 * Ensure reorder_objects is read after pd->lock is dropped so we see
+	 * an increment from another task in padata_do_serial.  Pairs with
+	 * spin_unlock(&pqueue->reorder.lock) in padata_do_serial.
 	 */
+	smp_mb();
 	if (atomic_read(&pd->reorder_objects)
 			&& !(pinst->flags & PADATA_RESET))
 		mod_timer(&pd->timer, jiffies + HZ);

base-commit: 0ecfebd2b52404ae0c54a878c872bb93363ada36
-- 
2.22.0
