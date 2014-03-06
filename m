From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 05/16] kernel/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:12 +0100
Message-ID: <1394121083-2507-6-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:47471 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbaCFPve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:34 -0500
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:33 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB8B82190041
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:25 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpHKO65011864
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:17 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpRtA017396
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:28 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Convert all compat system call functions where all parameter types
have a size of four or less than four bytes, or are pointer types
to COMPAT_SYSCALL_DEFINE.
The implicit casts within COMPAT_SYSCALL_DEFINE will perform proper
zero and sign extension to 64 bit of all parameters if needed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 kernel/compat.c | 90 ++++++++++++++++++++++++++++-----------------------------
 kernel/ptrace.c |  4 +--
 2 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/kernel/compat.c b/kernel/compat.c
index 0a09e481b70b..2622011a44c9 100644
--- a/kernel/compat.c
+++ b/kernel/compat.c
@@ -110,8 +110,8 @@ static int compat_put_timex(struct compat_timex __user *utp, struct timex *txc)
 	return 0;
 }
 
-asmlinkage long compat_sys_gettimeofday(struct compat_timeval __user *tv,
-		struct timezone __user *tz)
+COMPAT_SYSCALL_DEFINE2(gettimeofday, struct compat_timeval __user *, tv,
+		       struct timezone __user *, tz)
 {
 	if (tv) {
 		struct timeval ktv;
@@ -127,8 +127,8 @@ asmlinkage long compat_sys_gettimeofday(struct compat_timeval __user *tv,
 	return 0;
 }
 
-asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv,
-		struct timezone __user *tz)
+COMPAT_SYSCALL_DEFINE2(settimeofday, struct compat_timeval __user *, tv,
+		       struct timezone __user *, tz)
 {
 	struct timespec kts;
 	struct timezone ktz;
@@ -236,8 +236,8 @@ static long compat_nanosleep_restart(struct restart_block *restart)
 	return ret;
 }
 
-asmlinkage long compat_sys_nanosleep(struct compat_timespec __user *rqtp,
-				     struct compat_timespec __user *rmtp)
+COMPAT_SYSCALL_DEFINE2(nanosleep, struct compat_timespec __user *, rqtp,
+		       struct compat_timespec __user *, rmtp)
 {
 	struct timespec tu, rmt;
 	mm_segment_t oldfs;
@@ -328,7 +328,7 @@ static compat_clock_t clock_t_to_compat_clock_t(clock_t x)
 	return compat_jiffies_to_clock_t(clock_t_to_jiffies(x));
 }
 
-asmlinkage long compat_sys_times(struct compat_tms __user *tbuf)
+COMPAT_SYSCALL_DEFINE1(times, struct compat_tms __user *, tbuf)
 {
 	if (tbuf) {
 		struct tms tms;
@@ -354,7 +354,7 @@ asmlinkage long compat_sys_times(struct compat_tms __user *tbuf)
  * types that can be passed to put_user()/get_user().
  */
 
-asmlinkage long compat_sys_sigpending(compat_old_sigset_t __user *set)
+COMPAT_SYSCALL_DEFINE1(sigpending, compat_old_sigset_t __user *, set)
 {
 	old_sigset_t s;
 	long ret;
@@ -424,8 +424,8 @@ COMPAT_SYSCALL_DEFINE3(sigprocmask, int, how,
 
 #endif
 
-asmlinkage long compat_sys_setrlimit(unsigned int resource,
-		struct compat_rlimit __user *rlim)
+COMPAT_SYSCALL_DEFINE2(setrlimit, unsigned int, resource,
+		       struct compat_rlimit __user *, rlim)
 {
 	struct rlimit r;
 
@@ -443,8 +443,8 @@ asmlinkage long compat_sys_setrlimit(unsigned int resource,
 
 #ifdef COMPAT_RLIM_OLD_INFINITY
 
-asmlinkage long compat_sys_old_getrlimit(unsigned int resource,
-		struct compat_rlimit __user *rlim)
+COMPAT_SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
+		       struct compat_rlimit __user *, rlim)
 {
 	struct rlimit r;
 	int ret;
@@ -470,8 +470,8 @@ asmlinkage long compat_sys_old_getrlimit(unsigned int resource,
 
 #endif
 
-asmlinkage long compat_sys_getrlimit(unsigned int resource,
-		struct compat_rlimit __user *rlim)
+COMPAT_SYSCALL_DEFINE2(getrlimit, unsigned int, resource,
+		       struct compat_rlimit __user *, rlim)
 {
 	struct rlimit r;
 	int ret;
@@ -596,9 +596,9 @@ static int compat_get_user_cpu_mask(compat_ulong_t __user *user_mask_ptr,
 	return compat_get_bitmap(k, user_mask_ptr, len * 8);
 }
 
-asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid,
-					     unsigned int len,
-					     compat_ulong_t __user *user_mask_ptr)
+COMPAT_SYSCALL_DEFINE3(sched_setaffinity, compat_pid_t, pid,
+		       unsigned int, len,
+		       compat_ulong_t __user *, user_mask_ptr)
 {
 	cpumask_var_t new_mask;
 	int retval;
@@ -616,8 +616,8 @@ out:
 	return retval;
 }
 
-asmlinkage long compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
-					     compat_ulong_t __user *user_mask_ptr)
+COMPAT_SYSCALL_DEFINE3(sched_getaffinity, compat_pid_t,  pid, unsigned int, len,
+		       compat_ulong_t __user *, user_mask_ptr)
 {
 	int ret;
 	cpumask_var_t mask;
@@ -662,9 +662,9 @@ int put_compat_itimerspec(struct compat_itimerspec __user *dst,
 	return 0;
 }
 
-long compat_sys_timer_create(clockid_t which_clock,
-			struct compat_sigevent __user *timer_event_spec,
-			timer_t __user *created_timer_id)
+COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clock,
+		       struct compat_sigevent __user *, timer_event_spec,
+		       timer_t __user *, created_timer_id)
 {
 	struct sigevent __user *event = NULL;
 
@@ -680,9 +680,9 @@ long compat_sys_timer_create(clockid_t which_clock,
 	return sys_timer_create(which_clock, event, created_timer_id);
 }
 
-long compat_sys_timer_settime(timer_t timer_id, int flags,
-			  struct compat_itimerspec __user *new,
-			  struct compat_itimerspec __user *old)
+COMPAT_SYSCALL_DEFINE4(timer_settime, timer_t, timer_id, int, flags,
+		       struct compat_itimerspec __user *, new,
+		       struct compat_itimerspec __user *, old)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -703,8 +703,8 @@ long compat_sys_timer_settime(timer_t timer_id, int flags,
 	return err;
 }
 
-long compat_sys_timer_gettime(timer_t timer_id,
-		struct compat_itimerspec __user *setting)
+COMPAT_SYSCALL_DEFINE2(timer_gettime, timer_t, timer_id,
+		       struct compat_itimerspec __user *, setting)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -720,8 +720,8 @@ long compat_sys_timer_gettime(timer_t timer_id,
 	return err;
 }
 
-long compat_sys_clock_settime(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_settime, clockid_t, which_clock,
+		       struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -737,8 +737,8 @@ long compat_sys_clock_settime(clockid_t which_clock,
 	return err;
 }
 
-long compat_sys_clock_gettime(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_gettime, clockid_t, which_clock,
+		       struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -754,8 +754,8 @@ long compat_sys_clock_gettime(clockid_t which_clock,
 	return err;
 }
 
-long compat_sys_clock_adjtime(clockid_t which_clock,
-		struct compat_timex __user *utp)
+COMPAT_SYSCALL_DEFINE2(clock_adjtime, clockid_t, which_clock,
+		       struct compat_timex __user *, utp)
 {
 	struct timex txc;
 	mm_segment_t oldfs;
@@ -777,8 +777,8 @@ long compat_sys_clock_adjtime(clockid_t which_clock,
 	return ret;
 }
 
-long compat_sys_clock_getres(clockid_t which_clock,
-		struct compat_timespec __user *tp)
+COMPAT_SYSCALL_DEFINE2(clock_getres, clockid_t, which_clock,
+		       struct compat_timespec __user *, tp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -818,9 +818,9 @@ static long compat_clock_nanosleep_restart(struct restart_block *restart)
 	return err;
 }
 
-long compat_sys_clock_nanosleep(clockid_t which_clock, int flags,
-			    struct compat_timespec __user *rqtp,
-			    struct compat_timespec __user *rmtp)
+COMPAT_SYSCALL_DEFINE4(clock_nanosleep, clockid_t, which_clock, int, flags,
+		       struct compat_timespec __user *, rqtp,
+		       struct compat_timespec __user *, rmtp)
 {
 	long err;
 	mm_segment_t oldfs;
@@ -1010,7 +1010,7 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait, compat_sigset_t __user *, uthese,
 
 /* compat_time_t is a 32 bit "long" and needs to get converted. */
 
-asmlinkage long compat_sys_time(compat_time_t __user * tloc)
+COMPAT_SYSCALL_DEFINE1(time, compat_time_t __user *, tloc)
 {
 	compat_time_t i;
 	struct timeval tv;
@@ -1026,7 +1026,7 @@ asmlinkage long compat_sys_time(compat_time_t __user * tloc)
 	return i;
 }
 
-asmlinkage long compat_sys_stime(compat_time_t __user *tptr)
+COMPAT_SYSCALL_DEFINE1(stime, compat_time_t __user *, tptr)
 {
 	struct timespec tv;
 	int err;
@@ -1046,7 +1046,7 @@ asmlinkage long compat_sys_stime(compat_time_t __user *tptr)
 
 #endif /* __ARCH_WANT_COMPAT_SYS_TIME */
 
-asmlinkage long compat_sys_adjtimex(struct compat_timex __user *utp)
+COMPAT_SYSCALL_DEFINE1(adjtimex, struct compat_timex __user *, utp)
 {
 	struct timex txc;
 	int err, ret;
@@ -1085,10 +1085,10 @@ asmlinkage long compat_sys_move_pages(pid_t pid, unsigned long nr_pages,
 	return sys_move_pages(pid, nr_pages, pages, nodes, status, flags);
 }
 
-asmlinkage long compat_sys_migrate_pages(compat_pid_t pid,
-			compat_ulong_t maxnode,
-			const compat_ulong_t __user *old_nodes,
-			const compat_ulong_t __user *new_nodes)
+COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
+		       compat_ulong_t, maxnode,
+		       const compat_ulong_t __user *, old_nodes,
+		       const compat_ulong_t __user *, new_nodes)
 {
 	unsigned long __user *old = NULL;
 	unsigned long __user *new = NULL;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 1f4bcb3cc21c..adf98622cb32 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1180,8 +1180,8 @@ int compat_ptrace_request(struct task_struct *child, compat_long_t request,
 	return ret;
 }
 
-asmlinkage long compat_sys_ptrace(compat_long_t request, compat_long_t pid,
-				  compat_long_t addr, compat_long_t data)
+COMPAT_SYSCALL_DEFINE4(ptrace, compat_long_t, request, compat_long_t, pid,
+		       compat_long_t, addr, compat_long_t, data)
 {
 	struct task_struct *child;
 	long ret;
-- 
1.8.4.5
