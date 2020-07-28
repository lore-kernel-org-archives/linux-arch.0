From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 28 Jul 2020 15:39:12 -0400
Message-ID: <16fe117e-32a9-03be-258b-96755bde706a@redhat.com>
References: <20200403205930.1707-1-alex.kogan@oracle.com>
 <20200403205930.1707-5-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------18E4374909FF1CBF89E91B09"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44946 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728927AbgG1Tj1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Jul 2020 15:39:27 -0400
In-Reply-To: <20200403205930.1707-5-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com

This is a multi-part message in MIME format.
--------------18E4374909FF1CBF89E91B09
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/20 4:59 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> ---

A major issue with setting a limit on the maximum intra-node lock 
transfer is that the worst case latency where a lock can be transferred 
to another node is indeterminant. How about changing it to a time-based 
limit?

Cheers,
Longman



--------------18E4374909FF1CBF89E91B09
Content-Type: text/x-patch; charset=UTF-8;
 name="0007-locking-qspinlock-Convert-to-time-based-spinlock-thr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0007-locking-qspinlock-Convert-to-time-based-spinlock-thr.pa";
 filename*1="tch"

From 56b7cfcd417e13b4bfeb77ca290185726c05e69a Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Tue, 28 Jul 2020 12:07:56 -0400
Subject: [PATCH 7/9] locking/qspinlock: Convert to time based spinlock
 threshold

The "numa_spinlock_threshold" kernel command line parameter specifies
the number of maximum intra-node lock transfers allowed in a continuously
contended lock. Depending on how long the lock critical section lasts,
the actual maximum latency can vary quite a lot.

Controlling that maximum latency is actually more meaningful than
just the number of intra-node lock transfers. By running a locking
microbenchmark with null critcal section on a 2-socket x86-64 system,
the locking rate was about 4,875 kop/s.  The default threshold of
64k translates to about 13ms in intra-node lock transfers. Of course,
with a slow critical section, the actual maximum latency will increase
substantially.

Change the kernel parameter to be time based (in ms) so that the users
have a better handle on what maximum latency to expect for inter-node
lock transfers. The default is currently set to 10ms. A range of
1-100ms is allowed. That ms value is translated internally to the
nearest rounded-up jiffies.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++---
 kernel/locking/qspinlock_cna.h                | 44 +++++++++++++------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 96eb7aae4f63..945e346c678f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3339,12 +3339,13 @@
 			numa_spinlock=auto.
 
 	numa_spinlock_threshold=	[NUMA, PV_OPS]
-			Set the threshold for the number of intra-node
-			lock hand-offs before the NUMA-aware spinlock
-			is forced to be passed to a thread on another NUMA node.
-			Valid values are in the [0..31] range. Smaller values
-			result in a more fair, but less performant spinlock, and
-			vice versa. The default value is 16.
+			Set the time threshold in milliseconds for the
+			number of intra-node lock hand-offs before the
+			NUMA-aware spinlock is forced to be passed to
+			a thread on another NUMA node.	Valid values
+			are in the [1..100] range. Smaller values result
+			in a more fair, but less performant spinlock,
+			and vice versa. The default value is 10.
 
 	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
 			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index 911c96279494..03e8ba71a537 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -60,7 +60,7 @@ struct cna_node {
 	u16			real_numa_node;
 	u32			encoded_tail;	/* self */
 	u32			partial_order;	/* encoded tail or enum val */
-	u32			intra_count;
+	s32			start_time;
 };
 
 enum {
@@ -70,12 +70,22 @@ enum {
 };
 
 /*
- * Controls the threshold for the number of intra-node lock hand-offs before
- * the NUMA-aware variant of spinlock is forced to be passed to a thread on
- * another NUMA node. The default setting can be changed with the
- * "numa_spinlock_threshold" boot option.
+ * Controls the threshold time in ms (default = 10) for intra-node lock
+ * hand-offs before the NUMA-aware variant of spinlock is forced to be
+ * passed to a thread on another NUMA node. The default setting can be
+ * changed with the "numa_spinlock_threshold" boot option.
  */
-unsigned int intra_node_handoff_threshold __ro_after_init = 1 << 16;
+#define MSECS_TO_JIFFIES(m)	\
+	((m) + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ)
+static int intra_node_handoff_threshold __ro_after_init = MSECS_TO_JIFFIES(10);
+
+static inline bool intra_node_threshold_reached(struct cna_node *cn)
+{
+	s32 current_time = (s32)jiffies;
+	s32 threshold = cn->start_time + intra_node_handoff_threshold;
+
+	return current_time - threshold > 0;
+}
 
 static void __init cna_init_nodes_per_cpu(unsigned int cpu)
 {
@@ -125,7 +135,7 @@ static __always_inline void cna_init_node(struct mcs_spinlock *node)
 	struct cna_node *cn = (struct cna_node *)node;
 
 	cn->numa_node = priority ? CNA_PRIORITY_NODE : cn->real_numa_node;
-	cn->intra_count = 0;
+	cn->start_time = 0;
 }
 
 /*
@@ -295,7 +305,14 @@ static __always_inline u32 cna_wait_head_or_lock(struct qspinlock *lock,
 {
 	struct cna_node *cn = (struct cna_node *)node;
 
-	if (cn->intra_count < intra_node_handoff_threshold) {
+	/*
+	 * In case the previous node passed over the special start_time
+	 * of 0, a refetch of jiffies should be either 0 or 1.
+	 */
+	if (!cn->start_time)
+		cn->start_time = (s32)jiffies;
+
+	if (!intra_node_threshold_reached(cn)) {
 		/*
 		 * We are at the head of the wait queue, no need to use
 		 * the fake NUMA node ID.
@@ -339,8 +356,7 @@ static inline void cna_lock_handoff(struct mcs_spinlock *node,
 		next = node->next;
 		if (node->locked > 1) {
 			val = node->locked;	/* preseve secondary queue */
-			((struct cna_node *)next)->intra_count =
-				cn->intra_count + 1;
+			((struct cna_node *)next)->start_time = cn->start_time;
 		}
 	} else if (node->locked > 1) {
 		/*
@@ -404,14 +420,14 @@ void __init cna_configure_spin_lock_slowpath(void)
 
 static int __init numa_spinlock_threshold_setup(char *str)
 {
-	int new_threshold_param;
+	int param;
 
-	if (get_option(&str, &new_threshold_param)) {
+	if (get_option(&str, &param)) {
 		/* valid value is between 0 and 31 */
-		if (new_threshold_param < 0 || new_threshold_param > 31)
+		if (param <= 0 || param > 100)
 			return 0;
 
-		intra_node_handoff_threshold = 1 << new_threshold_param;
+		intra_node_handoff_threshold = msecs_to_jiffies(param);
 		return 1;
 	}
 
-- 
2.18.1


--------------18E4374909FF1CBF89E91B09--
