From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 04/26] signal/drbd: Use send_sig not force_sig
Date: Wed, 22 May 2019 19:38:54 -0500
Message-ID: <20190523003916.20726-5-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, drbd-dev@lists.linbit.com
List-Id: linux-arch.vger.kernel.org

The drbd module exclusively sends signals to kernel threads it creates with
kthread_create.  These kernel threads do not block or ignore signals (only
flush signals after they have been delivered), nor can drbd threads
possibly be pid namespace init processes so the extra work that force_sig
performs that send_sig does not is unnecessary.

Further force_sig is for delivering synchronous signals (aka exceptions).
The locking in force_sig is not prepared to deal with running processes, as
tsk->sighand may change during exec for a running process.

In short it is not only unnecessary for drbd to use force_sig it is
semantically wrong.

With drbd using send_sig it becomes easier to maintain force_sig as only
synchronous signals need to be considered.

Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: drbd-dev@lists.linbit.com
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/block/drbd/drbd_int.h  | 2 +-
 drivers/block/drbd/drbd_main.c | 2 +-
 drivers/block/drbd/drbd_nl.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 549c64df9708..035829435710 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1972,7 +1972,7 @@ static inline void wake_ack_receiver(struct drbd_connection *connection)
 {
 	struct task_struct *task = connection->ack_receiver.task;
 	if (task && get_t_state(&connection->ack_receiver) == RUNNING)
-		force_sig(SIGXCPU, task);
+		send_sig(SIGXCPU, task, 1);
 }
 
 static inline void request_ping(struct drbd_connection *connection)
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 714eb64fabfd..8597aefe027b 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -477,7 +477,7 @@ void _drbd_thread_stop(struct drbd_thread *thi, int restart, int wait)
 		smp_mb();
 		init_completion(&thi->stop);
 		if (thi->task != current)
-			force_sig(DRBD_SIGKILL, thi->task);
+			send_sig(DRBD_SIGKILL, thi->task, 1);
 	}
 
 	spin_unlock_irqrestore(&thi->t_lock, flags);
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index 1cb5a0b85fd9..638b3ba9b976 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -611,7 +611,7 @@ void conn_try_outdate_peer_async(struct drbd_connection *connection)
 	struct task_struct *opa;
 
 	kref_get(&connection->kref);
-	/* We may just have force_sig()'ed this thread
+	/* We may have just sent a signal to this thread
 	 * to get it out of some blocking network function.
 	 * Clear signals; otherwise kthread_run(), which internally uses
 	 * wait_on_completion_killable(), will mistake our pending signal
-- 
2.21.0
