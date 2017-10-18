From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 2/4][PoC][RFC] Add rlimit-events framework
Date: Wed, 18 Oct 2017 22:32:28 +0200
Message-ID: <20171018203230.29871-3-k.opasiak@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203333epcas1p3d8dd8f3a755cb6ee8e9dde63cb91851b@epcas1p3.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171018203230.29871-1-k.opasiak@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com, Krzysztof Opasiak <k.opasiak@samsung.com>
List-Id: linux-arch.vger.kernel.org

Add a framework which allows to notify userspace programs
about change of resource (the same as in rlimits) usage.

To monitor some process, monitor FD has to be obtained from
kernel using rlimit-events netlink interface.
Then monitor can issue ioctls() to subscribe for a particular
usage level of given resource.
When monitoring subject crosses given usage level monitoring
fd will be ready to read resource change event from it.

It's possible to monitor multiple processes and single
process can be monitored by multiple other processes.

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 include/asm-generic/resource.h   |  37 +-
 include/linux/init_task.h        |   1 +
 include/linux/rlimit_noti_kern.h |  54 +++
 include/linux/sched/signal.h     |   6 +
 include/uapi/linux/netlink.h     |   1 +
 include/uapi/linux/rlimit_noti.h |  71 ++++
 init/Kconfig                     |   6 +
 kernel/Makefile                  |   1 +
 kernel/rlimit_noti.c             | 786 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 962 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/rlimit_noti_kern.h
 create mode 100644 include/uapi/linux/rlimit_noti.h
 create mode 100644 kernel/rlimit_noti.c

diff --git a/include/asm-generic/resource.h b/include/asm-generic/resource.h
index 5e752b959054..338f20ba7e56 100644
--- a/include/asm-generic/resource.h
+++ b/include/asm-generic/resource.h
@@ -2,7 +2,7 @@
 #define _ASM_GENERIC_RESOURCE_H
 
 #include <uapi/asm-generic/resource.h>
-
+#include <linux/spinlock.h>
 
 /*
  * boot-time rlimit defaults for the init task:
@@ -27,4 +27,39 @@
 	[RLIMIT_RTTIME]		= {  RLIM_INFINITY,  RLIM_INFINITY },	\
 }
 
+#ifdef CONFIG_RLIMIT_NOTIFICATION
+
+#define INIT_RLIMIT_WATCHER(watchers, limit)	\
+	[limit] = LIST_HEAD_INIT(watchers[limit])
+
+#define INIT_RLIMIT_WATCHERS(watchers)				\
+{								\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_CPU),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_FSIZE),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_DATA),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_STACK),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_CORE),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_RSS),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_NPROC),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_NOFILE),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_MEMLOCK),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_AS),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_LOCKS),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_SIGPENDING),	\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_MSGQUEUE),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_NICE),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_RTPRIO),		\
+	INIT_RLIMIT_WATCHER(watchers, RLIMIT_RTTIME),		\
+}
+
+#define INIT_RLIMIT_EVENTS_CTX(sig)					\
+.rlimit_events_ctx = {						\
+	.lock = __SPIN_LOCK_UNLOCKED(sig.rlimit_events_ctx.lock),	\
+	.watchers = INIT_RLIMIT_WATCHERS(sig.rlimit_events_ctx.watchers),\
+	.process_dead = 0,						\
+},
+#else
+#define INIT_RLIMIT_EVENTS_CTX(sig)
+#endif /* CONFIG_RLIMIT_NOTIFICATION */
+
 #endif
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index e049526bc188..65400b376b92 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -76,6 +76,7 @@ extern struct fs_struct init_fs;
 	INIT_POSIX_TIMERS(sig)						\
 	INIT_CPU_TIMERS(sig)						\
 	.rlim		= INIT_RLIMITS,					\
+	INIT_RLIMIT_EVENTS_CTX(sig)					\
 	INIT_CPUTIMER(sig)						\
 	INIT_PREV_CPUTIME(sig)						\
 	.cred_guard_mutex =						\
diff --git a/include/linux/rlimit_noti_kern.h b/include/linux/rlimit_noti_kern.h
new file mode 100644
index 000000000000..e49fddaa21c0
--- /dev/null
+++ b/include/linux/rlimit_noti_kern.h
@@ -0,0 +1,54 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_RLIMIT_NOTI_H_
+#define _LINUX_RLIMIT_NOTI_H_
+
+#include <uapi/linux/rlimit_noti.h>
+
+struct rlimit_noti_ctx {
+	/* for mdification protection */
+	spinlock_t lock;
+	/* protected by RCU */
+	struct list_head watchers[RLIM_NLIMITS];
+
+	unsigned process_dead:1;
+};
+
+#ifdef CONFIG_RLIMIT_NOTIFICATION
+
+int rlimit_noti_task_fork(struct task_struct *parent,
+			  struct task_struct *child);
+
+void rlimit_noti_task_exit(struct task_struct *tsk);
+
+int rlimit_noti_watch_active(struct task_struct *tsk, unsigned int res);
+
+void rlimit_noti_res_changed(struct task_struct *tsk, unsigned int res,
+			     uint64_t old, uint64_t new);
+
+#else
+
+static inline int rlimit_noti_watch_active(struct task_struct *tsk,
+					   unsigned int res)
+{
+	return 0;
+}
+
+static inline void rlimit_noti_res_changed(struct task_struct *tsk,
+					   unsigned int res,
+					   uint64_t old, uint64_t new)
+{
+}
+
+#endif /* CONFIG_RLIMIT_NOTIFICATION */
+#endif /* _LINUX_RLIMIT_NOTI_H_ */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 05cef037fbf2..36849df51c5b 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -7,7 +7,9 @@
 #include <linux/sched/jobctl.h>
 #include <linux/sched/task.h>
 #include <linux/cred.h>
+#include <linux/list.h>
 
+#include <linux/rlimit_noti_kern.h>
 /*
  * Types defining task->signal and task->sighand and APIs using them:
  */
@@ -197,6 +199,10 @@ struct signal_struct {
 	 */
 	struct rlimit rlim[RLIM_NLIMITS];
 
+#ifdef CONFIG_RLIMIT_NOTIFICATION
+	struct rlimit_noti_ctx rlimit_events_ctx;
+#endif
+
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct pacct_struct pacct;	/* per-process accounting information */
 #endif
diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
index f86127a46cfc..24b55805d607 100644
--- a/include/uapi/linux/netlink.h
+++ b/include/uapi/linux/netlink.h
@@ -28,6 +28,7 @@
 #define NETLINK_RDMA		20
 #define NETLINK_CRYPTO		21	/* Crypto layer */
 #define NETLINK_SMC		22	/* SMC monitoring */
+#define NETLINK_RLIMIT_EVENTS   23      /* rlimit notification */
 
 #define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG
 
diff --git a/include/uapi/linux/rlimit_noti.h b/include/uapi/linux/rlimit_noti.h
new file mode 100644
index 000000000000..a15a2826bce9
--- /dev/null
+++ b/include/uapi/linux/rlimit_noti.h
@@ -0,0 +1,71 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _UAPI_LINUX_RLIMIT_NOTI_H_
+#define _UAPI_LINUX_RLIMIT_NOTI_H_
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/resource.h>
+#else
+#include <stdint.h>
+#endif
+
+#define RLIMIT_GET_NOTI_FD 1000
+
+/* ioctl's */
+#define RLIMIT_ADD_NOTI_LVL 1
+#define RLIMIT_RM_NOTI_LVL 2
+
+#define RLIMIT_SET_NOTI_ALL 3
+#define RLIMIT_CLEAR_NOTI_ALL 4
+
+/*
+ * For future (notify every 5, 10 units change):
+ * #define RLIMIT_SET_NOTI_STEP 5
+ */
+
+#define RLIMIT_GET_NOTI_LVLS 6
+#define RLIMIT_GET_NOTI_LVL_COUNT 7
+
+/* Flags for ioctl's */
+#define RLIMIT_FLAG_NO_INHERIT (1u << 0)
+
+/* Event types */
+enum {
+	RLIMIT_EVENT_TYPE_RES_CHANGED,
+	RLIMIT_EVENT_TYPE_MAX
+};
+
+/* TODO take care of padding (packed) */
+struct rlimit_noti_subject {
+	pid_t pid;
+	uint32_t resource;
+};
+
+struct rlimit_noti_level {
+	struct rlimit_noti_subject subj;
+	uint64_t value;
+	uint32_t flags;
+};
+
+struct rlimit_event {
+	uint32_t ev_type;
+	size_t size;
+};
+
+struct rlimit_event_res_changed {
+	struct rlimit_noti_subject subj;
+	uint64_t new_value;
+};
+
+#endif /* _UAPI_LINUX_RLIMIT_NOTI_H_ */
diff --git a/init/Kconfig b/init/Kconfig
index 1d3475fc9496..4bc44fa86640 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -332,6 +332,12 @@ config AUDIT_TREE
 	depends on AUDITSYSCALL
 	select FSNOTIFY
 
+config RLIMIT_NOTIFICATION
+       bool "Support fd notifications on given resource usage"
+       depends on NET
+       help
+	Enable this to monitor process resource changes usage via fd.
+
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 72aa080f91f0..d927d41c35f5 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_AUDIT) += audit.o auditfilter.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_AUDIT_WATCH) += audit_watch.o audit_fsnotify.o
 obj-$(CONFIG_AUDIT_TREE) += audit_tree.o
+obj-$(CONFIG_RLIMIT_NOTIFICATION) += rlimit_noti.o
 obj-$(CONFIG_GCOV_KERNEL) += gcov/
 obj-$(CONFIG_KCOV) += kcov.o
 obj-$(CONFIG_KPROBES) += kprobes.o
diff --git a/kernel/rlimit_noti.c b/kernel/rlimit_noti.c
new file mode 100644
index 000000000000..a4fe5b9dd02b
--- /dev/null
+++ b/kernel/rlimit_noti.c
@@ -0,0 +1,786 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Netlink communication strongly based on audit.c.
+ */
+
+#include <linux/rlimit_noti.h>
+
+#include <net/sock.h>
+#include <net/netlink.h>
+#include <linux/skbuff.h>
+#include <net/netns/generic.h>
+
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/wait.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/pid.h>
+#include <linux/pid_namespace.h>
+#include <linux/anon_inodes.h>
+#include <linux/sched/signal.h>
+#include <linux/spinlock.h>
+
+#define sig_watchers(sig) sig->rlimit_events_ctx.watchers
+
+#define sig_for_each_res(wlist, sig)					\
+	for (wlist = &sig_watchers(sig)[0];				\
+	     wlist - &sig_watchers(sig)[0] < ARRAY_SIZE(sig_watchers(sig)); \
+	     ++wlist)
+
+struct rlimit_event_list {
+	struct rlimit_event ev;
+	union {
+		struct rlimit_event_res_changed rchanged;
+	} event_data;
+	struct list_head node;
+};
+
+#define MAX_RLIMIT_EVENT_SIZE ({					\
+			struct rlimit_event_list *_rl = NULL;	\
+			sizeof(_rl->event_data);		\
+})
+
+struct rlimit_watch_fd_ctx {
+	struct kref kref;
+
+	spinlock_t noti_ctx_lock;
+	struct list_head watchers;
+	unsigned fd_invalid:1;
+
+	spinlock_t events_lock;
+	wait_queue_head_t events_queue;
+	struct list_head events;
+};
+
+struct rlimit_watcher {
+	struct rcu_head rcu;
+	struct rlimit_watch_fd_ctx *ctx;
+	struct signal_struct *signal;
+
+	struct list_head tsk_node;
+	struct list_head ctx_node;
+
+	uint64_t value;
+	unsigned noti_all_changes:1;
+};
+
+/******************************************************************************
+ * Public API
+ ******************************************************************************/
+
+static void release_ctx(struct kref *kref)
+{
+	struct rlimit_watch_fd_ctx *ctx =
+		container_of(kref, struct rlimit_watch_fd_ctx, kref);
+
+	kfree(ctx);
+}
+
+static struct rlimit_watcher *alloc_rlimit_watcher(
+	struct rlimit_watch_fd_ctx *ctx, struct signal_struct *signal,
+	uint64_t value, bool noti_all)
+{
+	struct rlimit_watcher *w;
+
+	w = kzalloc(sizeof(*w), GFP_ATOMIC);
+	if (!w)
+		return ERR_PTR(ENOMEM);
+
+	INIT_LIST_HEAD(&w->tsk_node);
+	INIT_LIST_HEAD(&w->ctx_node);
+
+	w->ctx = ctx;
+	kref_get(&ctx->kref);
+	w->signal = signal;
+	get_signal_struct(signal);
+	w->value = value;
+	w->noti_all_changes = noti_all;
+
+	return w;
+}
+
+static void free_rlimit_watcher(struct rlimit_watcher *w)
+{
+	if (!w)
+		return;
+
+	kref_put(&w->ctx->kref, release_ctx);
+	put_signal_struct(w->signal);
+	kfree(w);
+}
+
+static void free_rlimit_watcher_rcu(struct rcu_head *head)
+{
+	free_rlimit_watcher(container_of(head, struct rlimit_watcher, rcu));
+}
+
+static inline struct rlimit_watcher *rlimit_watcher_dup(
+	struct rlimit_watcher *org, struct task_struct *new_owner)
+{
+	return alloc_rlimit_watcher(org->ctx, new_owner->signal, org->value,
+				    org->noti_all_changes);
+}
+
+/* This is not called for threads */
+int rlimit_noti_task_fork(struct task_struct *parent, struct task_struct *child)
+{
+	struct rlimit_watcher *w, *nw;
+	struct signal_struct *sig = child->signal;
+	unsigned long flags;
+	struct list_head *iter;
+	int ret;
+
+	/*
+	 * init all list to avoid leaving uninitialized lists
+	 * in case of error
+	 */
+	sig_for_each_res(iter, sig)
+		INIT_LIST_HEAD(iter);
+
+	spin_lock_init(&sig->rlimit_events_ctx.lock);
+	sig->rlimit_events_ctx.process_dead = 0;
+
+	/* Lock the list to be safe against modification */
+	spin_lock_irqsave(&parent->signal->rlimit_events_ctx.lock, flags);
+
+	sig_for_each_res(iter, sig)
+		list_for_each_entry(w, iter, tsk_node) {
+			nw = rlimit_watcher_dup(w, child);
+			if (!nw) {
+				spin_unlock_irqrestore(
+					&parent->signal->rlimit_events_ctx.lock,
+					flags);
+				ret = -ENOMEM;
+				goto cleanup;
+			}
+
+			/*
+			 * For now we put this only on task side list
+			 * to avoid deadlock (ABBA)
+			 *
+			 * We assume that no one can access this new task
+			 * for now so we don't use any locking here
+			 */
+			list_add_tail_rcu(&nw->tsk_node, iter);
+		}
+
+	/*
+	 * now we got all watchers on our brand new list so we can release
+	 * parent lock and allow modification of its list
+	 */
+	spin_unlock_irqrestore(&parent->signal->rlimit_events_ctx.lock, flags);
+
+	sig_for_each_res(iter, sig) {
+start_again:
+		rcu_read_lock();
+		list_for_each_entry_rcu(w, iter, tsk_node) {
+			spin_lock_irqsave(&w->ctx->noti_ctx_lock, flags);
+			if (list_empty(&w->ctx_node)) {
+				if (!w->ctx->fd_invalid) {
+					list_add_tail(&w->ctx_node,
+						      &w->ctx->watchers);
+				} else {
+					spin_lock(&sig->rlimit_events_ctx.lock);
+					list_del_rcu(&w->tsk_node);
+					call_rcu(&w->rcu,
+						 free_rlimit_watcher_rcu);
+					spin_unlock(
+						&sig->rlimit_events_ctx.lock);
+					rcu_read_unlock();
+					goto start_again;
+				}
+			}
+			spin_unlock_irqrestore(&w->ctx->noti_ctx_lock, flags);
+		}
+		rcu_read_unlock();
+	}
+
+	return 0;
+cleanup:
+	sig_for_each_res(iter, sig) {
+		while (!list_empty(iter)) {
+			w = list_first_entry(iter,
+					     struct rlimit_watcher, ctx_node);
+			list_del_init(&w->tsk_node);
+			call_rcu(&w->rcu, free_rlimit_watcher_rcu);
+		}
+	}
+	return ret;
+}
+
+void rlimit_noti_task_exit(struct task_struct *tsk)
+{
+	struct rlimit_watcher *w;
+	struct rlimit_noti_ctx *n_ctx = &tsk->signal->rlimit_events_ctx;
+	unsigned long flags;
+	struct list_head *head;
+
+	if (tsk != tsk->group_leader)
+		return;
+
+	/*
+	 * Let's mark that we are in the middle of cleaning up
+	 * to prevent new watchers from being added to the list
+	 */
+	spin_lock_irqsave(&n_ctx->lock, flags);
+	WARN_ON(n_ctx->process_dead);
+	n_ctx->process_dead = true;
+	spin_unlock_irqrestore(&n_ctx->lock, flags);
+
+	sig_for_each_res(head, tsk->signal) {
+		/*
+		 * Let's go through the list and remove watchers form respective
+		 * fd contextes.
+		 */
+		rcu_read_lock();
+		list_for_each_entry_rcu(w, head, tsk_node) {
+			spin_lock_irqsave(&w->ctx->noti_ctx_lock, flags);
+			/*
+			 * List empty means that between iteration and acquiring
+			 * lock this watcher has been already removed and
+			 * it's just hanging due to grace period
+			 */
+			if (!list_empty(&w->ctx_node)
+			    && !list_empty(&w->tsk_node))
+				list_del_init(&w->ctx_node);
+
+			spin_unlock_irqrestore(&w->ctx->noti_ctx_lock, flags);
+		}
+		rcu_read_unlock();
+
+		/* Now let's cleanup our list */
+		spin_lock_irqsave(&n_ctx->lock, flags);
+		while (!list_empty(head)) {
+			w = list_first_entry(head,
+					     struct rlimit_watcher, tsk_node);
+			list_del_rcu(&w->tsk_node);
+			call_rcu(&w->rcu, free_rlimit_watcher_rcu);
+		}
+		spin_unlock_irqrestore(&n_ctx->lock, flags);
+	}
+}
+
+static int rlimit_generate_res_changed_event(struct rlimit_watch_fd_ctx *ctx,
+					     struct task_struct *tsk,
+					     unsigned int resource,
+					     uint64_t new, int mflags)
+{
+	struct rlimit_event_list *ev_list;
+	unsigned long flags;
+
+	ev_list = kzalloc(sizeof(*ev_list), mflags);
+	if (!ev_list)
+		return -ENOMEM;
+
+	ev_list->ev.ev_type = RLIMIT_EVENT_TYPE_RES_CHANGED;
+	ev_list->ev.size = sizeof(struct rlimit_event)
+		+ sizeof(struct rlimit_event_res_changed);
+
+	/* TODO add here support for PID namespace */
+	ev_list->event_data.rchanged.subj.pid = tsk->pid;
+	ev_list->event_data.rchanged.subj.resource = resource;
+
+	ev_list->event_data.rchanged.new_value = new;
+
+	INIT_LIST_HEAD(&ev_list->node);
+
+	spin_lock_irqsave(&ctx->events_lock, flags);
+	list_add_tail(&ev_list->node, &ctx->events);
+	wake_up_interruptible(&ctx->events_queue);
+	spin_unlock_irqrestore(&ctx->events_lock, flags);
+
+	return 0;
+}
+
+int rlimit_noti_watch_active(struct task_struct *tsk, unsigned int res)
+{
+	return !list_empty(&tsk->signal->rlimit_events_ctx.watchers[res]);
+}
+
+void rlimit_noti_res_changed(struct task_struct *tsk, unsigned int res,
+			     uint64_t old, uint64_t new)
+{
+	struct rlimit_watcher *w;
+	struct signal_struct *signal = tsk->signal;
+
+	rcu_read_lock();
+	/* TODO this should be replaced with sth faster */
+	list_for_each_entry_rcu(w, &signal->rlimit_events_ctx.watchers[res],
+				tsk_node)
+		if (w->noti_all_changes ||
+		    (w->value > old && w->value <= new) ||
+		    (w->value > new && w->value <= old)) {
+			/* ignore error as there is nothing we can do */
+			rlimit_generate_res_changed_event(w->ctx, tsk,
+							  res, new, GFP_ATOMIC);
+		}
+	rcu_read_unlock();
+}
+
+/******************************************************************************
+ * FD part
+ ******************************************************************************/
+
+static int add_new_watcher(struct rlimit_watch_fd_ctx *ctx,
+			   struct task_struct *tsk,
+			   int resource, uint64_t value, bool noti_all)
+{
+	struct rlimit_watcher *w;
+	struct signal_struct *signal;
+	unsigned long flags;
+	int ret = 0;
+
+	if (resource >= RLIM_NLIMITS)
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+	if (!tsk->sighand) {
+		ret = -ESRCH;
+		goto unlock_read;
+	}
+
+	task_lock(tsk->group_leader);
+	signal = tsk->signal;
+
+	w = alloc_rlimit_watcher(ctx, signal, value, noti_all);
+	if (IS_ERR(w)) {
+		ret = PTR_ERR(w);
+		goto unlock_group_leader;
+	}
+
+	spin_lock_irqsave(&ctx->noti_ctx_lock, flags);
+	/*
+	 * First add it to ctx list as we are holding it's lock
+	 * and no one is going to modify or iterate it
+	 */
+	list_add_tail(&w->ctx_node, &ctx->watchers);
+	/* Now let's lock process side lock and add this torcu protected list */
+	spin_lock(&signal->rlimit_events_ctx.lock);
+
+	/* If process is in the middle of cleanup let's rollback everything */
+	if (!signal->rlimit_events_ctx.process_dead) {
+		list_add_tail_rcu(&signal->rlimit_events_ctx.watchers[resource],
+				  &w->tsk_node);
+		ret = 0;
+	} else {
+		list_del(&w->ctx_node);
+		free_rlimit_watcher(w);
+		ret = -ENOENT;
+	}
+
+	spin_unlock(&signal->rlimit_events_ctx.lock);
+	spin_unlock_irqrestore(&ctx->noti_ctx_lock, flags);
+unlock_group_leader:
+	task_unlock(tsk->group_leader);
+unlock_read:
+	read_unlock(&tasklist_lock);
+
+	return ret;
+}
+
+ssize_t rlimit_noti_read_event(struct file *file, char __user *buf,
+			       size_t size, loff_t *ptr)
+{
+	struct rlimit_watch_fd_ctx *ctx = file->private_data;
+	struct rlimit_event_list *ev_list;
+	unsigned long flags;
+	size_t ret;
+
+	/* TODO allow to read only part of event */
+	if (size < MAX_RLIMIT_EVENT_SIZE)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ctx->events_lock, flags);
+#define READ_COND (!list_empty(&ctx->events))
+	while (!READ_COND) {
+		spin_unlock_irqrestore(&ctx->events_lock, flags);
+
+		if (wait_event_interruptible(ctx->events_queue, READ_COND))
+			return -ERESTARTSYS;
+		spin_lock_irqsave(&ctx->events_lock, flags);
+	}
+#undef READ_COND
+
+	ev_list = list_first_entry(&ctx->events,
+				   struct rlimit_event_list, node);
+	list_del(&ev_list->node);
+	spin_unlock_irqrestore(&ctx->events_lock, flags);
+
+	/* TODO handle fault */
+	ret = copy_to_user(buf, &ev_list->ev, ev_list->ev.size);
+	if (ret == 0)
+		ret = ev_list->ev.size;
+
+	kfree(ev_list);
+
+	return ret;
+}
+
+
+unsigned int rlimit_noti_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct rlimit_watch_fd_ctx *ctx = file->private_data;
+	unsigned int mask = POLLWRNORM;
+	unsigned long flags;
+
+	poll_wait(file, &ctx->events_queue, wait);
+
+	spin_lock_irqsave(&ctx->events_lock, flags);
+	if (!list_empty(&ctx->events))
+		mask |= POLLIN;
+
+	/* TODO add notification when last process exited */
+	spin_unlock_irqrestore(&ctx->events_lock, flags);
+
+	return mask;
+}
+
+
+static long rlimit_noti_ioctl(struct file *file,
+			      unsigned int cmd, unsigned long arg)
+{
+	struct rlimit_watch_fd_ctx *ctx = file->private_data;
+	struct task_struct *tsk;
+	struct rlimit_noti_level nlvl;
+	bool noti_all = false;
+	int ret;
+
+	switch (cmd) {
+	case RLIMIT_SET_NOTI_ALL:
+		if (copy_from_user(&nlvl.subj,
+				   (void __user *)arg, sizeof(nlvl.subj)))
+			return -EFAULT;
+
+		nlvl.value = 0;
+		noti_all = true;
+		goto set_watch;
+
+	case RLIMIT_ADD_NOTI_LVL:
+		if (copy_from_user(&nlvl, (void __user *)arg, sizeof(nlvl)))
+			return -EFAULT;
+set_watch:
+		rcu_read_lock();
+		tsk = find_task_by_vpid(nlvl.subj.pid);
+		if (!tsk) {
+			rcu_read_unlock();
+			printk(KERN_DEBUG "No PID in current NS\n");
+			return -EINVAL;
+		}
+
+		get_task_struct(tsk);
+		rcu_read_unlock();
+
+		/* TODO check for duplicates before adding */
+		ret = add_new_watcher(ctx, tsk, nlvl.subj.resource,
+				      nlvl.value, false);
+		put_task_struct(tsk);
+		break;
+
+	case RLIMIT_CLEAR_NOTI_ALL:
+	case RLIMIT_RM_NOTI_LVL:
+
+	case RLIMIT_GET_NOTI_LVLS:
+	case RLIMIT_GET_NOTI_LVL_COUNT:
+		/* TODO: Implement me */
+		ret = -ENOTSUPP;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int rlimit_noti_release(struct inode *inode, struct file *file)
+{
+	struct rlimit_watch_fd_ctx *ctx = file->private_data;
+	struct rlimit_watcher *w;
+	struct rlimit_event_list *ev_list;
+	unsigned long flags;
+
+	/* Clean up watchers */
+	spin_lock_irqsave(&ctx->noti_ctx_lock, flags);
+	ctx->fd_invalid = 1;
+	list_for_each_entry(w, &ctx->watchers, ctx_node) {
+		spin_lock(&w->signal->rlimit_events_ctx.lock);
+		list_del_rcu(&w->tsk_node);
+		spin_unlock(&w->signal->rlimit_events_ctx.lock);
+	}
+
+	while (!list_empty(&ctx->watchers)) {
+		w = list_first_entry(&ctx->watchers,
+				     struct rlimit_watcher, ctx_node);
+		list_del_init(&w->ctx_node);
+		call_rcu(&w->rcu, free_rlimit_watcher_rcu);
+	}
+
+	spin_unlock_irqrestore(&ctx->noti_ctx_lock, flags);
+
+	/* to ensure that no more events will be generated */
+	synchronize_rcu();
+
+	spin_lock_irqsave(&ctx->events_lock, flags);
+	while (!list_empty(&ctx->events)) {
+		ev_list = list_first_entry(&ctx->events,
+					   struct rlimit_event_list, node);
+		list_del(&ev_list->node);
+		kfree(ev_list);
+	}
+	spin_unlock_irqrestore(&ctx->events_lock, flags);
+
+	kref_put(&ctx->kref, release_ctx);
+
+	return 0;
+}
+
+static const struct file_operations rlimit_noti_fops = {
+	.read = rlimit_noti_read_event,
+	.release = rlimit_noti_release,
+	.poll = rlimit_noti_poll,
+	.unlocked_ioctl = rlimit_noti_ioctl,
+};
+
+static int rlimit_noti_create_fd(void)
+{
+	struct rlimit_watch_fd_ctx *ctx;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	kref_init(&ctx->kref);
+	spin_lock_init(&ctx->noti_ctx_lock);
+	INIT_LIST_HEAD(&ctx->watchers);
+	spin_lock_init(&ctx->events_lock);
+	INIT_LIST_HEAD(&ctx->events);
+	init_waitqueue_head(&ctx->events_queue);
+
+	ret = anon_inode_getfd("rlimit_noti", &rlimit_noti_fops, ctx, 0);
+	if (ret < 0)
+		goto put_ctx;
+
+	return ret;
+put_ctx:
+	kref_put(&ctx->kref, release_ctx);
+	return ret;
+}
+
+
+
+/******************************************************************************
+ * netlink part
+ ******************************************************************************/
+
+
+/* private rlimit_noti network namespace index */
+static unsigned int rlimit_noti_net_id;
+
+struct rlimit_noti_net {
+	struct sock *sk;
+};
+
+struct rlimit_noti_reply {
+	__u32 portid;
+	struct net *net;
+	struct sk_buff *skb;
+};
+
+static struct sock *rlimit_noti_get_socket(const struct net *net)
+{
+	struct rlimit_noti_net *rn_net;
+
+	if (!net)
+		return NULL;
+
+	rn_net = net_generic(net, rlimit_noti_net_id);
+	return rn_net->sk;
+}
+
+static struct sk_buff *rlimit_noti_make_reply(int seq, int type,
+					      void *payload, int size)
+{
+	struct sk_buff	*skb;
+	struct nlmsghdr	*nl_header;
+	int flags = 0;
+
+	skb = nlmsg_new(size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	nl_header = nlmsg_put(skb, 0, seq, type, size, flags);
+	if (!nl_header)
+		goto free_skb;
+
+	memcpy(nlmsg_data(nl_header), payload, size);
+
+	return skb;
+
+free_skb:
+	kfree_skb(skb);
+	return NULL;
+}
+
+static int rlimit_noti_send_reply_thread(void *arg)
+{
+	struct rlimit_noti_reply *reply = arg;
+	struct sock *sk = rlimit_noti_get_socket(reply->net);
+
+	/*
+	 * Ignore failure. It'll only happen if the sender goes away,
+	 * because our timeout is set to infinite.
+	 */
+	netlink_unicast(sk, reply->skb, reply->portid, 0);
+	put_net(reply->net);
+	kfree(reply);
+	return 0;
+}
+
+static void rlimit_noti_send_reply(struct sk_buff *request_skb, int seq,
+				   int type, void *payload, int size)
+{
+	struct net *net = sock_net(NETLINK_CB(request_skb).sk);
+	struct sk_buff *skb;
+	struct task_struct *tsk;
+	struct rlimit_noti_reply *reply;
+
+	reply = kmalloc(sizeof(*reply), GFP_KERNEL);
+	if (!reply)
+		return;
+
+	skb = rlimit_noti_make_reply(seq, type, payload, size);
+	if (!skb)
+		goto out;
+
+	reply->net = get_net(net);
+	reply->portid = NETLINK_CB(request_skb).portid;
+	reply->skb = skb;
+
+	tsk = kthread_run(rlimit_noti_send_reply_thread, reply,
+			  "rlimit_noti_send_reply");
+	if (!IS_ERR(tsk))
+		return;
+	kfree_skb(skb);
+out:
+	kfree(reply);
+}
+
+static int rlimit_noti_netlink_ok(struct sk_buff *skb, u16 msg_type)
+{
+	/* TODO: put here some security and namespace checks */
+	return 0;
+}
+
+static int rlimit_noti_receive_msg(struct sk_buff *skb,
+				   struct nlmsghdr *nl_header)
+{
+	u32 seq_nb = nl_header->nlmsg_seq;
+	u16 msg_type = nl_header->nlmsg_type;
+	int ret;
+
+	ret = rlimit_noti_netlink_ok(skb, msg_type);
+	if (ret)
+		return ret;
+
+	switch (msg_type) {
+	case RLIMIT_GET_NOTI_FD: {
+		int fd = 10;
+
+		fd = rlimit_noti_create_fd();
+		if (fd < 0) {
+			ret = fd;
+			goto out;
+		}
+		rlimit_noti_send_reply(skb, seq_nb, RLIMIT_GET_NOTI_FD,
+				       &fd, sizeof(fd));
+		ret = 0;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+out:
+	return ret;
+}
+
+static void rlimit_noti_netlink_receive(struct sk_buff *skb)
+{
+	struct nlmsghdr *nl_header;
+	int len, ret;
+
+	nl_header = nlmsg_hdr(skb);
+	len = skb->len;
+
+	while (nlmsg_ok(nl_header, len)) {
+		ret = rlimit_noti_receive_msg(skb, nl_header);
+		/* if err or if this message says it wants a response */
+		if (ret || (nl_header->nlmsg_flags & NLM_F_ACK))
+			netlink_ack(skb, nl_header, ret, NULL);
+
+		nl_header = nlmsg_next(nl_header, &len);
+	}
+}
+
+static int rlimit_noti_netlink_bind(struct net *net, int group)
+{
+	/* For now we allow everyone but maybe this should be limited? */
+	return 0;
+}
+
+static int __net_init rlimit_noti_net_init(struct net *net)
+{
+	struct netlink_kernel_cfg cfg = {
+		.input	= rlimit_noti_netlink_receive,
+		.bind	= rlimit_noti_netlink_bind,
+		.flags	= NL_CFG_F_NONROOT_RECV,
+		.groups	= 1, /* Just one, the default */
+	};
+	struct rlimit_noti_net *rn_net = net_generic(net, rlimit_noti_net_id);
+
+	rn_net->sk = netlink_kernel_create(net, NETLINK_RLIMIT_EVENTS, &cfg);
+	if (rn_net->sk == NULL) {
+		printk(KERN_ERR
+		       "cannot initialize netlink socket in namespace");
+		return -ENOMEM;
+	}
+	rn_net->sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
+
+	return 0;
+
+}
+
+static void __net_exit rlimit_noti_net_exit(struct net *net)
+{
+	struct rlimit_noti_net *rn_net = net_generic(net, rlimit_noti_net_id);
+
+	netlink_kernel_release(rn_net->sk);
+}
+
+static struct pernet_operations rlimit_noti_net_ops __net_initdata = {
+	.init = rlimit_noti_net_init,
+	.exit = rlimit_noti_net_exit,
+	.id = &rlimit_noti_net_id,
+	.size = sizeof(struct rlimit_noti_net),
+};
+
+static int __init rlimit_noti_init(void)
+{
+	return register_pernet_subsys(&rlimit_noti_net_ops);
+}
+late_initcall(rlimit_noti_init);
+
+static void __exit rlimit_noti_exit(void)
+{
+	unregister_pernet_subsys(&rlimit_noti_net_ops);
+}
-- 
2.9.3
