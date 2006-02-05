Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cabal.ca ([134.117.69.58]:10986 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750726AbWBETco (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 5 Feb 2006 14:32:44 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id 7AD7A23E83
	for <linux-arch@vger.kernel.org>; Sun,  5 Feb 2006 14:32:09 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15399-03 for <linux-arch@vger.kernel.org>;
	Sun, 5 Feb 2006 14:32:09 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (CPE0004ace53177-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.25.68.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id 08B3223E82
	for <linux-arch@vger.kernel.org>; Sun,  5 Feb 2006 14:32:08 -0500 (EST)
Date: Sun, 5 Feb 2006 14:31:29 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: [RFCv3] generic is_compat_task helper
Message-ID: <20060205193129.GA7566@quicksilver.road.mcmartin.ca>
References: <20060202065145.GA29845@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202065145.GA29845@quicksilver.road.mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Take 3... External facing interface implicitly uses current. Use
backend on parisc to clean up users in arch/parisc/kernel/ptrace.c which
act on *child. No generic CONFIG_COMPAT case, arch maintainers must add
their own (since they know best) to asm/compat.h.

diff --git a/include/asm-parisc/compat.h b/include/asm-parisc/compat.h
index 38b918f..22e3715 100644
--- a/include/asm-parisc/compat.h
+++ b/include/asm-parisc/compat.h
@@ -144,4 +144,14 @@ static __inline__ void __user *compat_al
 	return (void __user *)regs->gr[30];
 }
 
+static inline int __is_compat_task(struct task_struct *t)
+{
+	return (personality(t->personality) == PER_LINUX32);
+}
+
+static inline int is_compat_task(void)
+{
+	return __is_compat_task(current);
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..fb6f64f 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -161,5 +161,12 @@ int copy_siginfo_to_user32(struct compat
 int get_compat_sigevent(struct sigevent *event,
 		const struct compat_sigevent __user *u_event);
 
+#else /* !CONFIG_COMPAT */
+
+static inline int is_compat_task(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
