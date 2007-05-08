Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:47783 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933814AbXEHHYJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2007 03:24:09 -0400
Message-Id: <200705080723.l487NfbP016390@shell0.pdx.osdl.net>
Subject: [patch 015/455] reduce size of task_struct on 64-bit machines
From: akpm@linux-foundation.org
Date: Tue, 08 May 2007 00:23:41 -0700
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, wcohen@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: William Cohen <wcohen@redhat.com>

This past week I was playing around with that pahole tool
(http://oops.ghostprotocols.net:81/acme/dwarves/) and looking at the size
of various struct in the kernel.  I was surprised by the size of the
task_struct on x86_64, approaching 4K.  I looked through the fields in
task_struct and found that a number of them were declared as "unsigned
long" rather than "unsigned int" despite them appearing okay as 32-bit
sized fields.  On x86_64 "unsigned long" ends up being 8 bytes in size and
forces 8 byte alignment.  Is there a reason there a reason they are
"unsigned long"?

The patch below drops the size of the struct from 3808 bytes (60 64-byte
cachelines) to 3760 bytes (59 64-byte cachelines).  A couple other fields
in the task struct take a signficant amount of space:

struct thread_struct       thread;               688
struct held_lock           held_locks[30];       1680

CONFIG_LOCKDEP is turned on in the .config

[akpm@linux-foundation.org: fix printk warnings]
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/proc/array.c       |    4 ++--
 include/linux/sched.h |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff -puN fs/proc/array.c~reduce-size-of-task_struct-on-64-bit-machines fs/proc/array.c
--- a/fs/proc/array.c~reduce-size-of-task_struct-on-64-bit-machines
+++ a/fs/proc/array.c
@@ -410,9 +410,9 @@ static int do_task_stat(struct task_stru
 	/* convert nsec -> ticks */
 	start_time = nsec_to_clock_t(start_time);
 
-	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
+	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %u %lu \
 %lu %lu %lu %lu %lu %ld %ld %ld %ld %d 0 %llu %lu %ld %lu %lu %lu %lu %lu \
-%lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu %llu\n",
+%lu %lu %lu %lu %lu %lu %lu %lu %d %d %u %u %llu\n",
 		task->pid,
 		tcomm,
 		state,
diff -puN include/linux/sched.h~reduce-size-of-task_struct-on-64-bit-machines include/linux/sched.h
--- a/include/linux/sched.h~reduce-size-of-task_struct-on-64-bit-machines
+++ a/include/linux/sched.h
@@ -801,8 +801,8 @@ struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
 	atomic_t usage;
-	unsigned long flags;	/* per process flags, defined below */
-	unsigned long ptrace;
+	unsigned int flags;	/* per process flags, defined below */
+	unsigned int ptrace;
 
 	int lock_depth;		/* BKL lock depth */
 
@@ -825,7 +825,7 @@ struct task_struct {
 	unsigned long long sched_time; /* sched_clock time spent running */
 	enum sleep_type sleep_type;
 
-	unsigned long policy;
+	unsigned int policy;
 	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
@@ -845,11 +845,11 @@ struct task_struct {
 
 /* task state */
 	struct linux_binfmt *binfmt;
-	long exit_state;
+	int exit_state;
 	int exit_code, exit_signal;
 	int pdeath_signal;  /*  The signal sent when the parent dies  */
 	/* ??? */
-	unsigned long personality;
+	unsigned int personality;
 	unsigned did_exec:1;
 	pid_t pid;
 	pid_t tgid;
@@ -881,7 +881,7 @@ struct task_struct {
 	int __user *set_child_tid;		/* CLONE_CHILD_SETTID */
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
-	unsigned long rt_priority;
+	unsigned int rt_priority;
 	cputime_t utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
_
