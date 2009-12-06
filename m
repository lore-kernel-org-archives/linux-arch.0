From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 13/23] plist: Make plist debugging raw_spinlock aware
Date: Sun, 06 Dec 2009 18:02:57 -0000
Message-ID: <20091206111957.806855005@linutronix.de>
References: <20091206110944.492100233@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934219AbZLFSD5@vger.kernel.org>
Content-Disposition: inline; filename=plist-make-core-lock-aware.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

plists are used with spinlocks and raw_spinlocks. Change the plist
debugging to handle both types.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/plist.h |   43 +++++++++++++++++++++++++++++++++++++------
 kernel/futex.c        |    6 +++---
 lib/plist.c           |    8 +++++---
 3 files changed, 45 insertions(+), 12 deletions(-)

Index: linux-2.6-tip/include/linux/plist.h
===================================================================
--- linux-2.6-tip.orig/include/linux/plist.h
+++ linux-2.6-tip/include/linux/plist.h
@@ -81,7 +81,8 @@ struct plist_head {
 	struct list_head prio_list;
 	struct list_head node_list;
 #ifdef CONFIG_DEBUG_PI_LIST
-	spinlock_t *lock;
+	raw_spinlock_t *rawlock;
+	spinlock_t *spinlock;
 #endif
 };
 
@@ -91,9 +92,11 @@ struct plist_node {
 };
 
 #ifdef CONFIG_DEBUG_PI_LIST
-# define PLIST_HEAD_LOCK_INIT(_lock)	.lock = _lock
+# define PLIST_HEAD_LOCK_INIT(_lock)		.spinlock = _lock
+# define PLIST_HEAD_LOCK_INIT_RAW(_lock)	.rawlock = _lock
 #else
 # define PLIST_HEAD_LOCK_INIT(_lock)
+# define PLIST_HEAD_LOCK_INIT_RAW(_lock)
 #endif
 
 #define _PLIST_HEAD_INIT(head)				\
@@ -107,11 +110,22 @@ struct plist_node {
  */
 #define PLIST_HEAD_INIT(head, _lock)			\
 {							\
-        _PLIST_HEAD_INIT(head),                         \
+	_PLIST_HEAD_INIT(head),				\
 	PLIST_HEAD_LOCK_INIT(&(_lock))			\
 }
 
 /**
+ * PLIST_HEAD_INIT_RAW - static struct plist_head initializer
+ * @head:	struct plist_head variable name
+ * @_lock:	lock to initialize for this list
+ */
+#define PLIST_HEAD_INIT_RAW(head, _lock)		\
+{							\
+	_PLIST_HEAD_INIT(head),				\
+	PLIST_HEAD_LOCK_INIT_RAW(&(_lock))		\
+}
+
+/**
  * PLIST_NODE_INIT - static struct plist_node initializer
  * @node:	struct plist_node variable name
  * @__prio:	initial node priority
@@ -119,13 +133,13 @@ struct plist_node {
 #define PLIST_NODE_INIT(node, __prio)			\
 {							\
 	.prio  = (__prio),				\
-	.plist = { _PLIST_HEAD_INIT((node).plist) }, 	\
+	.plist = { _PLIST_HEAD_INIT((node).plist) },	\
 }
 
 /**
  * plist_head_init - dynamic struct plist_head initializer
  * @head:	&struct plist_head pointer
- * @lock:	list spinlock, remembered for debugging
+ * @lock:	spinlock protecting the list (debugging)
  */
 static inline void
 plist_head_init(struct plist_head *head, spinlock_t *lock)
@@ -133,7 +147,24 @@ plist_head_init(struct plist_head *head,
 	INIT_LIST_HEAD(&head->prio_list);
 	INIT_LIST_HEAD(&head->node_list);
 #ifdef CONFIG_DEBUG_PI_LIST
-	head->lock = lock;
+	head->spinlock = lock;
+	head->rawlock = NULL;
+#endif
+}
+
+/**
+ * plist_head_init_raw - dynamic struct plist_head initializer
+ * @head:	&struct plist_head pointer
+ * @lock:	raw_spinlock protecting the list (debugging)
+ */
+static inline void
+plist_head_init_raw(struct plist_head *head, raw_spinlock_t *lock)
+{
+	INIT_LIST_HEAD(&head->prio_list);
+	INIT_LIST_HEAD(&head->node_list);
+#ifdef CONFIG_DEBUG_PI_LIST
+	head->rawlock = lock;
+	head->spinlock = NULL;
 #endif
 }
 
Index: linux-2.6-tip/kernel/futex.c
===================================================================
--- linux-2.6-tip.orig/kernel/futex.c
+++ linux-2.6-tip/kernel/futex.c
@@ -1004,7 +1004,7 @@ void requeue_futex(struct futex_q *q, st
 		plist_add(&q->list, &hb2->chain);
 		q->lock_ptr = &hb2->lock;
 #ifdef CONFIG_DEBUG_PI_LIST
-		q->list.plist.lock = &hb2->lock;
+		q->list.plist.spinlock = &hb2->lock;
 #endif
 	}
 	get_futex_key_refs(key2);
@@ -1040,7 +1040,7 @@ void requeue_pi_wake_futex(struct futex_
 
 	q->lock_ptr = &hb->lock;
 #ifdef CONFIG_DEBUG_PI_LIST
-	q->list.plist.lock = &hb->lock;
+	q->list.plist.spinlock = &hb->lock;
 #endif
 
 	wake_up_state(q->task, TASK_NORMAL);
@@ -1388,7 +1388,7 @@ static inline void queue_me(struct futex
 
 	plist_node_init(&q->list, prio);
 #ifdef CONFIG_DEBUG_PI_LIST
-	q->list.plist.lock = &hb->lock;
+	q->list.plist.spinlock = &hb->lock;
 #endif
 	plist_add(&q->list, &hb->chain);
 	q->task = current;
Index: linux-2.6-tip/lib/plist.c
===================================================================
--- linux-2.6-tip.orig/lib/plist.c
+++ linux-2.6-tip/lib/plist.c
@@ -54,9 +54,11 @@ static void plist_check_list(struct list
 
 static void plist_check_head(struct plist_head *head)
 {
-	WARN_ON(!head->lock);
-	if (head->lock)
-		WARN_ON_SMP(!spin_is_locked(head->lock));
+	WARN_ON(!head->rawlock && !head->spinlock);
+	if (head->rawlock)
+		WARN_ON_SMP(!raw_spin_is_locked(head->rawlock));
+	if (head->spinlock)
+		WARN_ON_SMP(!spin_is_locked(head->spinlock));
 	plist_check_list(&head->prio_list);
 	plist_check_list(&head->node_list);
 }
