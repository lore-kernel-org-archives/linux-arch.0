From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 10/16] ipc/compat: convert to COMPAT_SYSCALL_DEFINE
Date: Thu,  6 Mar 2014 16:51:17 +0100
Message-ID: <1394121083-2507-11-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114]:50503 "EHLO
	e06smtp18.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaCFPvh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:37 -0500
Received: from /spool/local
	by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:36 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 81FCC17D805A
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:52:09 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpKPi63307938
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:20 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpUkn017566
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:32 -0700
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
 ipc/compat.c    |  9 +++++----
 ipc/compat_mq.c | 16 ++++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/ipc/compat.c b/ipc/compat.c
index e1f4ab65660c..98b9016cab6c 100644
--- a/ipc/compat.c
+++ b/ipc/compat.c
@@ -498,7 +498,7 @@ static inline int put_compat_msqid_ds(struct msqid64_ds *m,
 	return err;
 }
 
-long compat_sys_msgctl(int first, int second, void __user *uptr)
+COMPAT_SYSCALL_DEFINE3(msgctl, int, first, int, second, void __user *, uptr)
 {
 	int err, err2;
 	struct msqid64_ds m64;
@@ -668,7 +668,7 @@ static inline int put_compat_shm_info(struct shm_info __user *ip,
 	return err;
 }
 
-long compat_sys_shmctl(int first, int second, void __user *uptr)
+COMPAT_SYSCALL_DEFINE3(shmctl, int, first, int, second, void __user *, uptr)
 {
 	void __user *p;
 	struct shmid64_ds s64;
@@ -749,8 +749,9 @@ long compat_sys_shmctl(int first, int second, void __user *uptr)
 	return err;
 }
 
-long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
-		unsigned nsops, const struct compat_timespec __user *timeout)
+COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
+		       unsigned, nsops,
+		       const struct compat_timespec __user *, timeout)
 {
 	struct timespec __user *ts64 = NULL;
 	if (timeout) {
diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
index 63d7c6de335b..af087fb40bf7 100644
--- a/ipc/compat_mq.c
+++ b/ipc/compat_mq.c
@@ -46,9 +46,9 @@ static inline int put_compat_mq_attr(const struct mq_attr *attr,
 		| __put_user(attr->mq_curmsgs, &uattr->mq_curmsgs);
 }
 
-asmlinkage long compat_sys_mq_open(const char __user *u_name,
-			int oflag, compat_mode_t mode,
-			struct compat_mq_attr __user *u_attr)
+COMPAT_SYSCALL_DEFINE4(mq_open, const char __user *, u_name,
+		       int, oflag, compat_mode_t, mode,
+		       struct compat_mq_attr __user *, u_attr)
 {
 	void __user *p = NULL;
 	if (u_attr && oflag & O_CREAT) {
@@ -105,8 +105,8 @@ asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
 			u_msg_prio, u_ts);
 }
 
-asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
-			const struct compat_sigevent __user *u_notification)
+COMPAT_SYSCALL_DEFINE2(mq_notify, mqd_t, mqdes,
+		       const struct compat_sigevent __user *, u_notification)
 {
 	struct sigevent __user *p = NULL;
 	if (u_notification) {
@@ -122,9 +122,9 @@ asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
 	return sys_mq_notify(mqdes, p);
 }
 
-asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
-			const struct compat_mq_attr __user *u_mqstat,
-			struct compat_mq_attr __user *u_omqstat)
+COMPAT_SYSCALL_DEFINE3(mq_getsetattr, mqd_t, mqdes,
+		       const struct compat_mq_attr __user *, u_mqstat,
+		       struct compat_mq_attr __user *, u_omqstat)
 {
 	struct mq_attr mqstat;
 	struct mq_attr __user *p = compat_alloc_user_space(2 * sizeof(*p));
-- 
1.8.4.5
