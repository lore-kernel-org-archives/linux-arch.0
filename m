Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	by smtps.tip.net.au (Postfix) with ESMTP id 0C753368008
	for <linux-arch@vger.kernel.org>; Tue,  8 Mar 2005 16:50:32 +1100 (EST)
Date: Tue, 8 Mar 2005 16:50:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] consolidate the last of the compat sigevent structs
Message-Id: <20050308165029.0653563c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi all,

This patch pulls together the compat_sigevent structs.  It also
consolidates the copying of these structures into the kernel.

The only part of the second union in sigevent that the kernel
looks at currently is the _tid, so that is the only bit we copy.

This patch depends on my previous two patches "add and use
COMPAT_SIGEV_PAD_SIZE" and "Consolidate the last compat sigvals".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

diffstat looks like this:
 arch/ia64/ia32/ia32priv.h         |   13 -------------
 arch/ia64/ia32/sys_ia32.c         |    9 ++-------
 arch/ppc64/kernel/sys_ppc32.c     |    9 +--------
 arch/s390/kernel/compat_linux.c   |   13 ++-----------
 arch/s390/kernel/compat_linux.h   |   17 -----------------
 arch/sparc64/kernel/sys_sparc32.c |    9 ++-------
 arch/x86_64/ia32/sys_ia32.c       |   16 ++--------------
 include/asm-sparc64/siginfo.h     |   22 ----------------------
 include/linux/compat.h            |    3 +++
 ipc/compat_mq.c                   |   14 --------------
 kernel/compat.c                   |   21 +++++++++++++++++++++
 11 files changed, 33 insertions(+), 113 deletions(-)

Built and run on PPC64.

If there are no objections, I will send this on to Andrew/Linus.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-sigval/arch/ia64/ia32/ia32priv.h linus-sigevent/arch/ia64/ia32/ia32priv.h
--- linus-sigval/arch/ia64/ia32/ia32priv.h	2005-03-07 17:52:28.000000000 +1100
+++ linus-sigevent/arch/ia64/ia32/ia32priv.h	2005-03-08 13:25:56.000000000 +1100
@@ -277,19 +277,6 @@ typedef struct compat_siginfo {
 	} _sifields;
 } compat_siginfo_t;
 
-typedef struct sigevent32 {
-	compat_sigval_t sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[COMPAT_SIGEV_PAD_SIZE];
-		struct {
-			u32 _function;
-			u32 _attribute; /* really pthread_attr_t */
-		} _sigev_thread;
-	} _sigev_un;
-} sigevent_t32;
-
 struct old_linux32_dirent {
 	u32	d_ino;
 	u32	d_offset;
diff -ruNp linus-sigval/arch/ia64/ia32/sys_ia32.c linus-sigevent/arch/ia64/ia32/sys_ia32.c
--- linus-sigval/arch/ia64/ia32/sys_ia32.c	2005-03-07 13:06:23.000000000 +1100
+++ linus-sigevent/arch/ia64/ia32/sys_ia32.c	2005-03-08 15:21:40.000000000 +1100
@@ -2592,7 +2592,7 @@ sys32_get_thread_area (struct ia32_user_
 }
 
 asmlinkage long
-sys32_timer_create(u32 clock, struct sigevent32 __user *se32, timer_t __user *timer_id)
+sys32_timer_create(u32 clock, struct compat_sigevent __user *se32, timer_t __user *timer_id)
 {
 	struct sigevent se;
 	mm_segment_t oldfs;
@@ -2602,12 +2602,7 @@ sys32_timer_create(u32 clock, struct sig
 	if (se32 == NULL)
 		return sys_timer_create(clock, NULL, timer_id);
 
-	memset(&se, 0, sizeof(struct sigevent));
-	if (get_user(se.sigev_value.sival_int,	&se32->sigev_value.sival_int) ||
-	    __get_user(se.sigev_signo, &se32->sigev_signo) ||
-	    __get_user(se.sigev_notify, &se32->sigev_notify) ||
-	    __copy_from_user(&se._sigev_un._pad, &se32->_sigev_un._pad,
-	    sizeof(se._sigev_un._pad)))
+	if (get_compat_sigevent(&se, se32))
 		return -EFAULT;
 
 	if (!access_ok(VERIFY_WRITE,timer_id,sizeof(timer_t)))
diff -ruNp linus-sigval/arch/ppc64/kernel/sys_ppc32.c linus-sigevent/arch/ppc64/kernel/sys_ppc32.c
--- linus-sigval/arch/ppc64/kernel/sys_ppc32.c	2005-01-29 06:05:47.000000000 +1100
+++ linus-sigevent/arch/ppc64/kernel/sys_ppc32.c	2005-03-08 15:23:17.000000000 +1100
@@ -1290,14 +1290,7 @@ long ppc32_timer_create(clockid_t clock,
 	if (ev32 == NULL)
 		return sys_timer_create(clock, NULL, timer_id);
 
-	memset(&event, 0, sizeof(event));
-	if (!access_ok(VERIFY_READ, ev32, sizeof(struct compat_sigevent))
-	    || __get_user(event.sigev_value.sival_int,
-			  &ev32->sigev_value.sival_int)
-	    || __get_user(event.sigev_signo, &ev32->sigev_signo)
-	    || __get_user(event.sigev_notify, &ev32->sigev_notify)
-	    || __get_user(event.sigev_notify_thread_id,
-			  &ev32->sigev_notify_thread_id))
+	if (get_compat_sigevent(&event, ev32))
 		return -EFAULT;
 
 	if (!access_ok(VERIFY_WRITE, timer_id, sizeof(timer_t)))
diff -ruNp linus-sigval/arch/s390/kernel/compat_linux.c linus-sigevent/arch/s390/kernel/compat_linux.c
--- linus-sigval/arch/s390/kernel/compat_linux.c	2005-02-11 13:05:29.000000000 +1100
+++ linus-sigevent/arch/s390/kernel/compat_linux.c	2005-03-08 15:24:35.000000000 +1100
@@ -1019,7 +1019,7 @@ extern asmlinkage long
 sys_timer_create(clockid_t, struct sigevent *, timer_t *);
 
 asmlinkage long
-sys32_timer_create(clockid_t which_clock, struct sigevent32 *se32,
+sys32_timer_create(clockid_t which_clock, struct compat_sigevent *se32,
 		timer_t *timer_id)
 {
 	struct sigevent se;
@@ -1030,16 +1030,7 @@ sys32_timer_create(clockid_t which_clock
 	if (se32 == NULL)
 		return sys_timer_create(which_clock, NULL, timer_id);
 
-	/* XXX: converting se32 to se is filthy because of the
-	 * two union members. For now it is ok, because the pointers
-	 * are not touched in kernel.
-	 */
-	memset(&se, 0, sizeof(se));
-	if (get_user(se.sigev_value.sival_int,  &se32->sigev_value.sival_int) ||
-	    get_user(se.sigev_signo, &se32->sigev_signo) ||
-	    get_user(se.sigev_notify, &se32->sigev_notify) ||
-	    copy_from_user(&se._sigev_un._pad, &se32->_sigev_un._pad,
-	    sizeof(se._sigev_un._pad)))
+	if (get_compat_sigevent(&se, se32))
 		return -EFAULT;
 
 	old_fs = get_fs();
diff -ruNp linus-sigval/arch/s390/kernel/compat_linux.h linus-sigevent/arch/s390/kernel/compat_linux.h
--- linus-sigval/arch/s390/kernel/compat_linux.h	2005-03-07 17:49:16.000000000 +1100
+++ linus-sigevent/arch/s390/kernel/compat_linux.h	2005-03-08 14:16:28.000000000 +1100
@@ -194,21 +194,4 @@ struct ucontext32 {
 	compat_sigset_t		uc_sigmask;	/* mask last for extensibility */
 };
 
-struct sigevent32 {
-	union {
-		int sival_int;
-		u32 sival_ptr;
-	} sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[COMPAT_SIGEV_PAD_SIZE];
-		int _tid;
-		struct {
-			u32 *_function;
-			u32 *_attribute;
-		} _sigev_thread;
-	} _sigev_un;
-};
-
 #endif /* _ASM_S390X_S390_H */
diff -ruNp linus-sigval/arch/sparc64/kernel/sys_sparc32.c linus-sigevent/arch/sparc64/kernel/sys_sparc32.c
--- linus-sigval/arch/sparc64/kernel/sys_sparc32.c	2005-03-07 13:06:23.000000000 +1100
+++ linus-sigevent/arch/sparc64/kernel/sys_sparc32.c	2005-03-08 15:25:36.000000000 +1100
@@ -1087,7 +1087,7 @@ sys_timer_create(clockid_t which_clock,
 		 timer_t __user *created_timer_id);
 
 long
-sys32_timer_create(u32 clock, struct sigevent32 __user *se32,
+sys32_timer_create(u32 clock, struct compat_sigevent __user *se32,
 		   timer_t __user *timer_id)
 {
 	struct sigevent se;
@@ -1098,12 +1098,7 @@ sys32_timer_create(u32 clock, struct sig
 	if (se32 == NULL)
 		return sys_timer_create(clock, NULL, timer_id);
 
-	memset(&se, 0, sizeof(struct sigevent));
-	if (get_user(se.sigev_value.sival_int,  &se32->sigev_value.sival_int) ||
-	    __get_user(se.sigev_signo, &se32->sigev_signo) ||
-	    __get_user(se.sigev_notify, &se32->sigev_notify) ||
-	    __copy_from_user(&se._sigev_un._pad, &se32->_sigev_un._pad,
-	    sizeof(se._sigev_un._pad)))
+	if (get_compat_sigevent(&se, se32))
 		return -EFAULT;
 
 	if (!access_ok(VERIFY_WRITE,timer_id,sizeof(timer_t)))
diff -ruNp linus-sigval/arch/x86_64/ia32/sys_ia32.c linus-sigevent/arch/x86_64/ia32/sys_ia32.c
--- linus-sigval/arch/x86_64/ia32/sys_ia32.c	2005-03-07 13:06:23.000000000 +1100
+++ linus-sigevent/arch/x86_64/ia32/sys_ia32.c	2005-03-08 15:27:14.000000000 +1100
@@ -993,31 +993,19 @@ asmlinkage long sys32_open(const char __
 	return fd;
 }
 
-struct sigevent32 { 
-	u32 sigev_value;
-	u32 sigev_signo; 
-	u32 sigev_notify; 
-	u32 payload[(64 / 4) - 3]; 
-}; 
-
 extern asmlinkage long
 sys_timer_create(clockid_t which_clock,
 		 struct sigevent __user *timer_event_spec,
 		 timer_t __user * created_timer_id);
 
 long
-sys32_timer_create(u32 clock, struct sigevent32 __user *se32, timer_t __user *timer_id)
+sys32_timer_create(u32 clock, struct compat_sigevent __user *se32, timer_t __user *timer_id)
 {
 	struct sigevent __user *p = NULL;
 	if (se32) { 
 		struct sigevent se;
 		p = compat_alloc_user_space(sizeof(struct sigevent));
-		memset(&se, 0, sizeof(struct sigevent)); 
-		if (get_user(se.sigev_value.sival_int,  &se32->sigev_value) ||
-		    __get_user(se.sigev_signo, &se32->sigev_signo) ||
-		    __get_user(se.sigev_notify, &se32->sigev_notify) ||
-		    __copy_from_user(&se._sigev_un._pad, &se32->payload, 
-				     sizeof(se32->payload)) ||
+		if (get_compat_sigevent(&se, se32) ||
 		    copy_to_user(p, &se, sizeof(se)))
 			return -EFAULT;
 	} 
diff -ruNp linus-sigval/include/asm-sparc64/siginfo.h linus-sigevent/include/asm-sparc64/siginfo.h
--- linus-sigval/include/asm-sparc64/siginfo.h	2005-03-07 17:49:55.000000000 +1100
+++ linus-sigevent/include/asm-sparc64/siginfo.h	2005-03-08 14:19:52.000000000 +1100
@@ -32,26 +32,4 @@ struct compat_siginfo;
 #define EMT_TAGOVF	(__SI_FAULT|1)	/* tag overflow */
 #define NSIGEMT		1
 
-#ifdef __KERNEL__
-
-#ifdef CONFIG_COMPAT
-
-typedef struct sigevent32 {
-	compat_sigval_t sigev_value;
-	int sigev_signo;
-	int sigev_notify;
-	union {
-		int _pad[COMPAT_SIGEV_PAD_SIZE];
-
-		struct {
-			u32 _function;
-			u32 _attribute;	/* really pthread_attr_t */
-		} _sigev_thread;
-	} _sigev_un;
-} sigevent_t32;
-
-#endif /* CONFIG_COMPAT */
-
-#endif /* __KERNEL__ */
-
 #endif
diff -ruNp linus-sigval/include/linux/compat.h linus-sigevent/include/linux/compat.h
--- linus-sigval/include/linux/compat.h	2005-03-07 14:07:26.000000000 +1100
+++ linus-sigevent/include/linux/compat.h	2005-03-08 14:38:57.000000000 +1100
@@ -155,5 +155,8 @@ long compat_put_bitmap(compat_ulong_t __
 		       unsigned long bitmap_size);
 int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from);
 int copy_siginfo_to_user32(struct compat_siginfo __user *to, siginfo_t *from);
+int get_compat_sigevent(struct sigevent *event,
+		const struct compat_sigevent __user *u_event);
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -ruNp linus-sigval/ipc/compat_mq.c linus-sigevent/ipc/compat_mq.c
--- linus-sigval/ipc/compat_mq.c	2004-07-17 08:44:05.000000000 +1000
+++ linus-sigevent/ipc/compat_mq.c	2005-03-08 14:33:15.000000000 +1100
@@ -102,20 +102,6 @@ asmlinkage ssize_t compat_sys_mq_timedre
 			u_msg_prio, u_ts);
 }
 
-static int get_compat_sigevent(struct sigevent *event,
-		const struct compat_sigevent __user *u_event)
-{
-	if (verify_area(VERIFY_READ, u_event, sizeof(*u_event)))
-		return -EFAULT;
-
-	return __get_user(event->sigev_value.sival_int,
-			  &u_event->sigev_value.sival_int)
-	     | __get_user(event->sigev_signo, &u_event->sigev_signo)
-	     | __get_user(event->sigev_notify, &u_event->sigev_notify)
-	     | __get_user(event->sigev_notify_thread_id,
-			  &u_event->sigev_notify_thread_id);
-}
-
 asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
 			const struct compat_sigevent __user *u_notification)
 {
diff -ruNp linus-sigval/kernel/compat.c linus-sigevent/kernel/compat.c
--- linus-sigval/kernel/compat.c	2005-03-07 13:06:24.000000000 +1100
+++ linus-sigevent/kernel/compat.c	2005-03-08 16:16:51.000000000 +1100
@@ -630,6 +630,27 @@ long compat_sys_clock_nanosleep(clockid_
 	return err;	
 } 
 
+/*
+ * We currently only need the following fields from the sigevent
+ * structure: sigev_value, sigev_signo, sig_notify and (sometimes
+ * sigev_notify_thread_id).  The others are handled in user mode.
+ * We also assume that copying sigev_value.sival_int is sufficient
+ * to keep all the bits of sigev_value.sival_ptr intact.
+ */
+int get_compat_sigevent(struct sigevent *event,
+		const struct compat_sigevent __user *u_event)
+{
+	memset(&event, 0, sizeof(*event));
+	return (!access_ok(VERIFY_READ, u_event, sizeof(*u_event)) ||
+		__get_user(event->sigev_value.sival_int,
+			&u_event->sigev_value.sival_int) ||
+		__get_user(event->sigev_signo, &u_event->sigev_signo) ||
+		__get_user(event->sigev_notify, &u_event->sigev_notify) ||
+		__get_user(event->sigev_notify_thread_id,
+			&u_event->sigev_notify_thread_id))
+		? -EFAULT : 0;
+}
+
 /* timer_create is architecture specific because it needs sigevent conversion */
 
 long compat_get_bitmap(unsigned long *mask, compat_ulong_t __user *umask,
