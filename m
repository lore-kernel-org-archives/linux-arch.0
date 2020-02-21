Return-Path: <SRS0=0XgO=4J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgBUNuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:40 -0500
Message-ID: <20200221134215.090538203@infradead.org>
Date: Fri, 21 Feb 2020 14:34:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 01/27] lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200221133417.h0rQp9RsXHKrRkVWfbqp7PfCL8l3CS9jjqZo1Nwc1yg@z>

nmi_enter() does lockdep_off() and hence lockdep ignores everything.

And NMI context makes it impossible to do full IN-NMI tracking like we
do IN-HARDIRQ, that could result in graph_lock recursion.

However, since look_up_lock_class() is lockless, we can find the class
of a lock that has prior use and detect IN-NMI after USED, just not
USED after IN-NMI.

NOTE: By shifting the lockdep_off() recursion count to bit-16, we can
easily differentiate between actual recursion and off.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   53 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -379,13 +379,13 @@ void lockdep_init_task(struct task_struc
 
 void lockdep_off(void)
 {
-	current->lockdep_recursion++;
+	current->lockdep_recursion += BIT(16);
 }
 EXPORT_SYMBOL(lockdep_off);
 
 void lockdep_on(void)
 {
-	current->lockdep_recursion--;
+	current->lockdep_recursion -= BIT(16);
 }
 EXPORT_SYMBOL(lockdep_on);
 
@@ -575,6 +575,7 @@ static const char *usage_str[] =
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
+	[LOCK_USAGE_STATES] = "IN-NMI",
 };
 #endif
 
@@ -787,6 +788,7 @@ static int count_matching_names(struct l
 	return count + 1;
 }
 
+/* used from NMI context -- must be lockless */
 static inline struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
@@ -4463,6 +4465,34 @@ void lock_downgrade(struct lockdep_map *
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
 
+/* NMI context !!! */
+static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock, int subclass)
+{
+	struct lock_class *class = look_up_lock_class(lock, subclass);
+
+	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
+	if (!class)
+		return;
+
+	if (!(class->usage_mask & LOCK_USED))
+		return;
+
+	hlock->class_idx = class - lock_classes;
+
+	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
+}
+
+static bool lockdep_nmi(void)
+{
+	if (current->lockdep_recursion & 0xFFFF)
+		return false;
+
+	if (!in_nmi())
+		return false;
+
+	return true;
+}
+
 /*
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
@@ -4473,8 +4503,25 @@ void lock_acquire(struct lockdep_map *lo
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(current->lockdep_recursion)) {
+		/* XXX allow trylock from NMI ?!? */
+		if (lockdep_nmi() && !trylock) {
+			struct held_lock hlock;
+
+			hlock.acquire_ip = ip;
+			hlock.instance = lock;
+			hlock.nest_lock = nest_lock;
+			hlock.irq_context = 2; // XXX
+			hlock.trylock = trylock;
+			hlock.read = read;
+			hlock.check = check;
+			hlock.hardirqs_off = true;
+			hlock.references = 0;
+
+			verify_lock_unused(lock, &hlock, subclass);
+		}
 		return;
+	}
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
