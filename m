From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 14/16] kexec/compat: convert to COMPAT_SYSCALL_DEFINE with changing parameter types
Date: Thu,  6 Mar 2014 16:51:21 +0100
Message-ID: <1394121083-2507-15-git-send-email-heiko.carstens@de.ibm.com>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:33407 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaCFPvk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Mar 2014 10:51:40 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 6 Mar 2014 15:51:38 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A883B1B08051
	for <linux-arch@vger.kernel.org>; Thu,  6 Mar 2014 15:51:19 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s26FpNS93670448
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 15:51:23 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s26FpWhG017689
	for <linux-arch@vger.kernel.org>; Thu, 6 Mar 2014 08:51:34 -0700
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
 include/linux/compat.h | 6 +++---
 include/linux/kexec.h  | 6 ------
 kernel/kexec.c         | 8 ++++----
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 8e636211f334..ef4834c5bcab 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -641,10 +641,10 @@ asmlinkage long compat_sys_futex(u32 __user *uaddr, int op, u32 val,
 		u32 val3);
 asmlinkage long compat_sys_getsockopt(int fd, int level, int optname,
 				      char __user *optval, int __user *optlen);
-asmlinkage long compat_sys_kexec_load(unsigned long entry,
-				      unsigned long nr_segments,
+asmlinkage long compat_sys_kexec_load(compat_ulong_t entry,
+				      compat_ulong_t nr_segments,
 				      struct compat_kexec_segment __user *,
-				      unsigned long flags);
+				      compat_ulong_t flags);
 asmlinkage long compat_sys_mq_getsetattr(mqd_t mqdes,
 			const struct compat_mq_attr __user *u_mqstat,
 			struct compat_mq_attr __user *u_omqstat);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 6d4066cdb5b5..a75641930049 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -127,12 +127,6 @@ extern asmlinkage long sys_kexec_load(unsigned long entry,
 					struct kexec_segment __user *segments,
 					unsigned long flags);
 extern int kernel_kexec(void);
-#ifdef CONFIG_COMPAT
-extern asmlinkage long compat_sys_kexec_load(unsigned long entry,
-				unsigned long nr_segments,
-				struct compat_kexec_segment __user *segments,
-				unsigned long flags);
-#endif
 extern struct page *kimage_alloc_control_pages(struct kimage *image,
 						unsigned int order);
 extern void crash_kexec(struct pt_regs *);
diff --git a/kernel/kexec.c b/kernel/kexec.c
index 60bafbed06ab..45601cf41bee 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1039,10 +1039,10 @@ void __weak crash_unmap_reserved_pages(void)
 {}
 
 #ifdef CONFIG_COMPAT
-asmlinkage long compat_sys_kexec_load(unsigned long entry,
-				unsigned long nr_segments,
-				struct compat_kexec_segment __user *segments,
-				unsigned long flags)
+COMPAT_SYSCALL_DEFINE4(kexec_load, compat_ulong_t, entry,
+		       compat_ulong_t, nr_segments,
+		       struct compat_kexec_segment __user *, segments,
+		       compat_ulong_t, flags)
 {
 	struct compat_kexec_segment in;
 	struct kexec_segment out, __user *ksegments;
-- 
1.8.4.5
