Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cabal.ca ([134.117.69.58]:56220 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1423036AbWBBGwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Feb 2006 01:52:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id 0065E23E83
	for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2006 01:52:50 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13036-06 for <linux-arch@vger.kernel.org>;
	Thu, 2 Feb 2006 01:52:50 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (CPE0004ace53177-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.25.68.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 938FE23E82
	for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2006 01:52:50 -0500 (EST)
Date: Thu, 2 Feb 2006 01:51:45 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: [RFCv2] generic is_compat_task helper
Message-ID: <20060202065145.GA29845@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Take two of is_compat_task... Add a default function that will get
optimized away in the !CONFIG_COMPAT case. Modify x86-64's
is_compat_task to take a struct task_struct * argument. parisc
at least can use the arg in several places in arch-dependant code to
clean up ugliness (fixing the fact that it uses PER_LINUX32 is also on
the agenda for later). There's only one arch indep user in the kernel
(drivers/input/evdev.c) right now, so it can be moved as architectures
which need it add the is_compat_task helper.

diff --git a/include/asm-parisc/compat.h b/include/asm-parisc/compat.h
index 38b918f..58ada24 100644
--- a/include/asm-parisc/compat.h
+++ b/include/asm-parisc/compat.h
@@ -5,6 +5,7 @@
  */
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/personality.h>
 
 #define COMPAT_USER_HZ 100
 
@@ -144,4 +145,9 @@ static __inline__ void __user *compat_al
 	return (void __user *)regs->gr[30];
 }
 
+static inline int is_compat_task(struct task_struct *t)
+{
+	return (personality(t->personality) == PER_LINUX32);
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff --git a/include/asm-x86_64/compat.h b/include/asm-x86_64/compat.h
index b37ab82..4ade2a6 100644
--- a/include/asm-x86_64/compat.h
+++ b/include/asm-x86_64/compat.h
@@ -202,9 +202,9 @@ static __inline__ void __user *compat_al
 	return (void __user *)regs->rsp - len; 
 }
 
-static inline int is_compat_task(void)
+static inline int is_compat_task(struct task_struct *t)
 {
-	return current_thread_info()->status & TS_COMPAT;
+	return t->thread_info->status & TS_COMPAT;
 }
 
 #endif /* _ASM_X86_64_COMPAT_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..1b70e49 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -161,5 +161,12 @@ int copy_siginfo_to_user32(struct compat
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
+#else /* !CONFIG_COMPAT */
+
+static inline int is_compat_task(struct task_struct *t) {
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
+
 #endif /* _LINUX_COMPAT_H */
