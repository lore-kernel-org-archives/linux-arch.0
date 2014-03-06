From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 03/16] ipc/compat_sys_msgrcv: change msgtyp type from long to compat_long_t
Date: Thu,  6 Mar 2014 16:51:10 +0100
Message-ID: <1394121083-2507-4-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp13.uk.ibm.com ([195.75.94.109]:54621 "EHLO
	e06smtp13.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753276AbaCFPve (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:34 -0500
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:31 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 07A372190063
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:25 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpGOe52166658
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:17 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpQUF017358
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:28 -0700
In-Reply-To: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

Change the type of compat_sys_msgrcv's msgtyp parameter from long
to compat_long_t, since compat user space passes only a 32 bit signed
value.
Let the compat wrapper do proper sign extension to 64 bit of this
parameter.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/linux/compat.h | 2 +-
 ipc/compat.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 4c42df3fce37..179b1da9e19f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -321,7 +321,7 @@ asmlinkage long compat_sys_semctl(int semid, int semnum, int cmd, int arg);
 asmlinkage long compat_sys_msgsnd(int msqid, compat_uptr_t msgp,
 		compat_ssize_t msgsz, int msgflg);
 asmlinkage long compat_sys_msgrcv(int msqid, compat_uptr_t msgp,
-		compat_ssize_t msgsz, long msgtyp, int msgflg);
+		compat_ssize_t msgsz, compat_long_t msgtyp, int msgflg);
 long compat_sys_msgctl(int first, int second, void __user *uptr);
 long compat_sys_shmctl(int first, int second, void __user *uptr);
 long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
diff --git a/ipc/compat.c b/ipc/compat.c
index f486b0096a67..e1f4ab65660c 100644
--- a/ipc/compat.c
+++ b/ipc/compat.c
@@ -430,9 +430,9 @@ COMPAT_SYSCALL_DEFINE4(msgsnd, int, msqid, compat_uptr_t, msgp,
 }
 
 COMPAT_SYSCALL_DEFINE5(msgrcv, int, msqid, compat_uptr_t, msgp,
-		       compat_ssize_t, msgsz, long, msgtyp, int, msgflg)
+		       compat_ssize_t, msgsz, compat_long_t, msgtyp, int, msgflg)
 {
-	return do_msgrcv(msqid, compat_ptr(msgp), (ssize_t)msgsz, msgtyp,
+	return do_msgrcv(msqid, compat_ptr(msgp), (ssize_t)msgsz, (long)msgtyp,
 			 msgflg, compat_do_msg_fill);
 }
 
-- 
1.8.4.5
