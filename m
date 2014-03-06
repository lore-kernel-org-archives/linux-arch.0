From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 12/16] ipc/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
Date: Thu,  6 Mar 2014 16:51:19 +0100
Message-ID: <1394121083-2507-13-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:54651 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304AbaCFPvi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:38 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:37 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 765962190041
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:30 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpMWS34275336
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:22 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpVEl017623
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:33 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

In order to allow the COMPAT_SYSCALL_DEFINE macro generate code that
performs proper zero and sign extension convert all 64 bit parameters
to their corresponding 32 bit compat counterparts.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/compat.h |  4 ++--
 ipc/compat_mq.c        | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index fea8ee9afe22..f670e591aff8 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -655,11 +655,11 @@ asmlinkage long compat_sys_mq_open(const char __user *u_name,
 			struct compat_mq_attr __user *u_attr);
 asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes,
 			const char __user *u_msg_ptr,
-			size_t msg_len, unsigned int msg_prio,
+			compat_size_t msg_len, unsigned int msg_prio,
 			const struct compat_timespec __user *u_abs_timeout);
 asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
 			char __user *u_msg_ptr,
-			size_t msg_len, unsigned int __user *u_msg_prio,
+			compat_size_t msg_len, unsigned int __user *u_msg_prio,
 			const struct compat_timespec __user *u_abs_timeout);
 asmlinkage long compat_sys_socketcall(int call, u32 __user *args);
 asmlinkage long compat_sys_sysctl(struct compat_sysctl_args __user *args);
diff --git a/ipc/compat_mq.c b/ipc/compat_mq.c
index af087fb40bf7..d58747293772 100644
--- a/ipc/compat_mq.c
+++ b/ipc/compat_mq.c
@@ -78,10 +78,10 @@ static int compat_prepare_timeout(struct timespec __user **p,
 	return 0;
 }
 
-asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes,
-			const char __user *u_msg_ptr,
-			size_t msg_len, unsigned int msg_prio,
-			const struct compat_timespec __user *u_abs_timeout)
+COMPAT_SYSCALL_DEFINE5(mq_timedsend, mqd_t, mqdes,
+		       const char __user *, u_msg_ptr,
+		       compat_size_t, msg_len, unsigned int, msg_prio,
+		       const struct compat_timespec __user *, u_abs_timeout)
 {
 	struct timespec __user *u_ts;
 
@@ -92,10 +92,10 @@ asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes,
 			msg_prio, u_ts);
 }
 
-asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes,
-			char __user *u_msg_ptr,
-			size_t msg_len, unsigned int __user *u_msg_prio,
-			const struct compat_timespec __user *u_abs_timeout)
+COMPAT_SYSCALL_DEFINE5(mq_timedreceive, mqd_t, mqdes,
+		       char __user *, u_msg_ptr,
+		       compat_size_t, msg_len, unsigned int __user *, u_msg_prio,
+		       const struct compat_timespec __user *, u_abs_timeout)
 {
 	struct timespec __user *u_ts;
 	if (compat_prepare_timeout(&u_ts, u_abs_timeout))
-- 
1.8.4.5
