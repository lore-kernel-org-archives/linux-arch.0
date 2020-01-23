From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v9 0/5] Add NUMA-awareness to qspinlock
Date: Thu, 23 Jan 2020 14:08:26 -0500
Message-ID: <9f8e040a-0684-41c9-0c2e-65d2a1e14c22@redhat.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <CAC4j=Y8rCeTX9oKKbh+dCdTP8Ud4hW1ybu+iE7t_nxMSYBOR5w@mail.gmail.com>
 <4e15fa1d-9540-3274-502a-4195a0d46f63@redhat.com>
 <20200123113547.GD18991@willie-the-truck>
 <54ba237b-e1db-c14c-7cff-b0be41731ba5@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C3B3D0C2A24A32A734C19393"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728792AbgAWTIj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 14:08:39 -0500
In-Reply-To: <54ba237b-e1db-c14c-7cff-b0be41731ba5@redhat.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Lihao Liang <lihaoliang@google.com>, Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, dave.dice@oracle.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com

This is a multi-part message in MIME format.
--------------C3B3D0C2A24A32A734C19393
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 1/23/20 10:25 AM, Waiman Long wrote:
> On 1/23/20 6:35 AM, Will Deacon wrote:
>> Hi folks,
>>
>> (I think Lihao is travelling at the moment, so he may be delayed in his
>> replies)
>>
>> On Wed, Jan 22, 2020 at 12:24:58PM -0500, Waiman Long wrote:
>>> On 1/22/20 6:45 AM, Lihao Liang wrote:
>>>> On Wed, Jan 22, 2020 at 10:28 AM Alex Kogan <alex.kogan@oracle.com> wrote:
>>>>> Summary
>>>>> -------
>>>>>
>>>>> Lock throughput can be increased by handing a lock to a waiter on the
>>>>> same NUMA node as the lock holder, provided care is taken to avoid
>>>>> starvation of waiters on other NUMA nodes. This patch introduces CNA
>>>>> (compact NUMA-aware lock) as the slow path for qspinlock. It is
>>>>> enabled through a configuration option (NUMA_AWARE_SPINLOCKS).
>>>>>
>>>> Thanks for your patches. The experimental results look promising!
>>>>
>>>> I understand that the new CNA qspinlock uses randomization to achieve
>>>> long-term fairness, and provides the numa_spinlock_threshold parameter
>>>> for users to tune. As Linux runs extremely diverse workloads, it is not
>>>> clear how randomization affects its fairness, and how users with
>>>> different requirements are supposed to tune this parameter.
>>>>
>>>> To this end, Will and I consider it beneficial to be able to answer the
>>>> following question:
>>>>
>>>> With different values of numa_spinlock_threshold and
>>>> SHUFFLE_REDUCTION_PROB_ARG, how long do threads running on different
>>>> sockets have to wait to acquire the lock? This is particularly relevant
>>>> in high contention situations when new threads keep arriving on the same
>>>> socket as the lock holder.
>>>>
>>>> In this email, I try to provide some formal analysis to address this
>>>> question. Let's assume the probability for the lock to stay on the
>>>> same socket is *at least* p, which corresponds to the probability for
>>>> the function probably(unsigned int num_bits) in the patch to return *false*,
>>>> where SHUFFLE_REDUCTION_PROB_ARG is passed as the value of num_bits to the
>>>> function.
>>> That is not strictly true from my understanding of the code. The
>>> probably() function does not come into play if a secondary queue is
>>> present. Also calling cna_scan_main_queue() doesn't guarantee that a
>>> waiter in the same node can be found. So the simple mathematical
>>> analysis isn't that applicable in this case. One will have to do an
>>> actual simulation to find out what the actual behavior will be.
>> It's certainly true that the analysis is based on the worst-case scenario,
>> but I think it's still worth considering. For example, the secondary queue
>> does not exist initially so it seems a bit odd that we only instantiate it
>> with < 1% probability.
>>
>> That said, my real concern with any of this is that it makes formal
>> modelling and analysis of the qspinlock considerably more challenging. I
>> would /really/ like to see an update to the TLA+ model we have of the
>> current implementation [1] and preferably also the userspace version I
>> hacked together [2] so that we can continue to test and validate changes
>> to the code outside of the usual kernel stress-testing.
> I do agree that the current CNA code is hard to model. The CNA lock
> behaves like a regular qspinlock in many cases. If the lock becomes
> fairly contended with waiters from different nodes, it will
> opportunistically switch to CNA mode where preference is given to
> waiters in the same node.

BTW, I added the attached draft lock_event patch on top of the v9 CNA
patch series to observe the behavior of the CNA lock. Using a 2-socket
96-thread x86-64 server, the lock event output after boot up was:

cna_intra_max=1942
cna_mainscan_hit=134
cna_merge_queue=73
cna_prescan_hit=16662
cna_prescan_miss=268
cna_splice_new=352
cna_splice_old=2415
lock_pending=130090
lock_slowpath=191868
lock_use_node2=135

After resetting the counts and running a 96-thread lock stress test for
10s, I got

cna_intra_max=65536
cna_mainscan_hit=46
cna_merge_queue=661
cna_prescan_hit=42486841
cna_prescan_miss=68
cna_splice_new=676
cna_splice_old=402
lock_pending=11012
lock_slowpath=44332335
lock_use_node2=57203

So the cna_intra_max does go to the maximum of 64k.

Cheers,
Longman


--------------C3B3D0C2A24A32A734C19393
Content-Type: text/x-patch;
 name="0006-locking-qspinlock-Enable-lock-events-tracking-for-CN.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0006-locking-qspinlock-Enable-lock-events-tracking-for-CN.pa";
 filename*1="tch"

From aa090c6f0a07d48dc4dcb22087cf4c17a25686d6 Mon Sep 17 00:00:00 2001
From: Waiman Long <longman@redhat.com>
Date: Thu, 23 Jan 2020 13:53:12 -0500
Subject: [PATCH 6/6] locking/qspinlock: Enable lock events tracking for CNA
 qspinlock code

Add some lock events for tracking the behavior of the CNA qspinlock
code. A new lockevent_max() function is added to find out the maximum
value that CNA intra_count can reach.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events.c      | 23 +++++++++++++++++++----
 kernel/locking/lock_events.h      | 11 +++++++++++
 kernel/locking/lock_events_list.h | 13 +++++++++++++
 kernel/locking/qspinlock_cna.h    | 21 ++++++++++++++++-----
 kernel/locking/qspinlock_stat.h   | 23 ++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index fa2c2f951c6b..0237cbbc94a2 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -120,14 +120,29 @@ static const struct file_operations fops_lockevent = {
 
 static bool __init skip_lockevent(const char *name)
 {
-	static int pv_on __initdata = -1;
+	static enum {
+		LOCK_UNKNOWN,
+		LOCK_NATIVE,
+		LOCK_PV,
+		LOCK_CNA,
+	} state __initdata = LOCK_UNKNOWN;
+
+	if (state == LOCK_UNKNOWN) {
+		if (pv_ops.lock.queued_spin_lock_slowpath ==
+		    native_queued_spin_lock_slowpath)
+			state = LOCK_NATIVE;
+		else if (pv_ops.lock.queued_spin_lock_slowpath ==
+			 pv_queued_spin_lock_slowpath)
+			state = LOCK_PV;
+		else
+			state = LOCK_CNA;
+	}
 
-	if (pv_on < 0)
-		pv_on = !pv_is_native_spin_unlock();
 	/*
 	 * Skip PV qspinlock events on bare metal.
 	 */
-	if (!pv_on && !memcmp(name, "pv_", 3))
+	if (((state != LOCK_PV)  && !memcmp(name, "pv_", 3)) ||
+	    ((state != LOCK_CNA) && !memcmp(name, "cna_", 4)))
 		return true;
 	return false;
 }
diff --git a/kernel/locking/lock_events.h b/kernel/locking/lock_events.h
index 8c7e7d25f09c..d8528725324c 100644
--- a/kernel/locking/lock_events.h
+++ b/kernel/locking/lock_events.h
@@ -50,11 +50,22 @@ static inline void __lockevent_add(enum lock_events event, int inc)
 
 #define lockevent_add(ev, c)	__lockevent_add(LOCKEVENT_ ##ev, c)
 
+static inline void __lockevent_max(enum lock_events event, unsigned long val)
+{
+	unsigned long max = raw_cpu_read(lockevents[event]);
+
+	if (val > max)
+		raw_cpu_write(lockevents[event], val);
+}
+
+#define lockevent_max(ev, v)	__lockevent_max(LOCKEVENT_ ##ev, v)
+
 #else  /* CONFIG_LOCK_EVENT_COUNTS */
 
 #define lockevent_inc(ev)
 #define lockevent_add(ev, c)
 #define lockevent_cond_inc(ev, c)
+#define lockevent_max(ev, v)
 
 #endif /* CONFIG_LOCK_EVENT_COUNTS */
 #endif /* __LOCKING_LOCK_EVENTS_H */
diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..df1042bb19e9 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -35,6 +35,19 @@ LOCK_EVENT(pv_wait_head)	/* # of vCPU wait's at the queue head	   */
 LOCK_EVENT(pv_wait_node)	/* # of vCPU wait's at non-head queue node */
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+/*
+ * Locking events for CNA qspinlock
+ */
+LOCK_EVENT(cna_prescan_hit)
+LOCK_EVENT(cna_prescan_miss)
+LOCK_EVENT(cna_mainscan_hit)
+LOCK_EVENT(cna_merge_queue)	/* # of queue merges (secondary -> primary) */
+LOCK_EVENT(cna_splice_new)	/* # of splices to new secondary queue	    */
+LOCK_EVENT(cna_splice_old)	/* # of splices to existing secondary queue */
+LOCK_EVENT(cna_intra_max)	/* Maximum intra_count value		    */
+#endif
+
 /*
  * Locking events for qspinlock
  *
diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
index f0b0c15dcf9d..2c410d67e094 100644
--- a/kernel/locking/qspinlock_cna.h
+++ b/kernel/locking/qspinlock_cna.h
@@ -193,6 +193,7 @@ static void cna_splice_tail(struct mcs_spinlock *node,
 	if (node->locked <= 1) { /* if secondary queue is empty */
 		/* create secondary queue */
 		last->next = first;
+		lockevent_inc(cna_splice_new);
 	} else {
 		/* add to the tail of the secondary queue */
 		struct mcs_spinlock *tail_2nd = decode_tail(node->locked);
@@ -200,6 +201,7 @@ static void cna_splice_tail(struct mcs_spinlock *node,
 
 		tail_2nd->next = first;
 		last->next = head_2nd;
+		lockevent_inc(cna_splice_old);
 	}
 
 	node->locked = ((struct cna_node *)last)->encoded_tail;
@@ -285,14 +287,15 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
 			cn->intra_count == intra_node_handoff_threshold ?
 				FLUSH_SECONDARY_QUEUE :
 				cna_scan_main_queue(node, node);
-
+	lockevent_cond_inc(cna_prescan_hit,
+			   cn->pre_scan_result == LOCAL_WAITER_FOUND);
 	return 0;
 }
 
 static inline void cna_pass_lock(struct mcs_spinlock *node,
 				 struct mcs_spinlock *next)
 {
-	struct cna_node *cn = (struct cna_node *)node;
+	struct cna_node *cn = (struct cna_node *)node, *next_cn;
 	struct mcs_spinlock *next_holder = next, *tail_2nd;
 	u32 val = 1;
 
@@ -311,20 +314,27 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 	 * pre-scan, and if so, try to find it in post-scan starting from the
 	 * node where pre-scan stopped (stored in @pre_scan_result)
 	 */
-	if (scan >= MIN_ENCODED_TAIL)
+	if (scan >= MIN_ENCODED_TAIL) {
 		scan = cna_scan_main_queue(node, decode_tail(scan));
+		lockevent_inc(cna_prescan_miss);
+		lockevent_cond_inc(cna_mainscan_hit,
+				   scan == LOCAL_WAITER_FOUND);
+	}
 
 	if (scan == LOCAL_WAITER_FOUND) {
 		next_holder = node->next;
+		next_cn = (struct cna_node *)next_holder;
+
 		/*
 		 * we unlock successor by passing a non-zero value,
 		 * so set @val to 1 iff @locked is 0, which will happen
 		 * if we acquired the MCS lock when its queue was empty
 		 */
 		val = node->locked ? node->locked : 1;
+
 		/* inc @intra_count if the secondary queue is not empty */
-		((struct cna_node *)next_holder)->intra_count =
-			cn->intra_count + (node->locked > 1);
+		next_cn->intra_count = cn->intra_count + (node->locked > 1);
+		lockevent_max(cna_intra_max, next_cn->intra_count);
 	} else if (node->locked > 1) {	  /* if secondary queue is not empty */
 		/* next holder will be the first node in the secondary queue */
 		tail_2nd = decode_tail(node->locked);
@@ -332,6 +342,7 @@ static inline void cna_pass_lock(struct mcs_spinlock *node,
 		next_holder = tail_2nd->next;
 		/* splice the secondary queue onto the head of the main queue */
 		tail_2nd->next = next;
+		lockevent_inc(cna_merge_queue);
 	}
 
 pass_lock:
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index e625bb410aa2..530f86477e0f 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -22,6 +22,18 @@
  */
 static DEFINE_PER_CPU(u64, pv_kick_time);
 
+#ifdef CONFIG_NUMA_AWARE_SPINLOCKS
+static inline bool lock_event_return_max(int id)
+{
+	return id == LOCKEVENT_cna_intra_max;
+}
+#else
+static inline bool lock_event_return_max(int id)
+{
+	return false;
+}
+#endif
+
 /*
  * Function to read and return the PV qspinlock counts.
  *
@@ -38,7 +50,7 @@ ssize_t lockevent_read(struct file *file, char __user *user_buf,
 {
 	char buf[64];
 	int cpu, id, len;
-	u64 sum = 0, kicks = 0;
+	u64 sum = 0, kicks = 0, val;
 
 	/*
 	 * Get the counter ID stored in file->f_inode->i_private
@@ -49,6 +61,15 @@ ssize_t lockevent_read(struct file *file, char __user *user_buf,
 		return -EBADF;
 
 	for_each_possible_cpu(cpu) {
+		val = per_cpu(lockevents[id], cpu);
+		if (lock_event_return_max(id)) {
+			/*
+			 * Find the maximum of all per-cpu values
+			 */
+			if (val > sum)
+				sum = val;
+			continue;
+		}
 		sum += per_cpu(lockevents[id], cpu);
 		/*
 		 * Need to sum additional counters for some of them
-- 
2.18.1


--------------C3B3D0C2A24A32A734C19393--
