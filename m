Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cabal.ca ([134.117.69.58]:18594 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S932454AbWAXAJh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Jan 2006 19:09:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by fattire.cabal.ca (Postfix) with ESMTP id F089423E84
	for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2006 19:09:35 -0500 (EST)
Received: from fattire.cabal.ca ([127.0.0.1])
	by localhost (fattire [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 30689-07 for <linux-arch@vger.kernel.org>;
	Mon, 23 Jan 2006 19:09:35 -0500 (EST)
Received: from quicksilver.road.mcmartin.ca (CPE0004ace53177-CM0012c9a9a56e.cpe.net.cable.rogers.com [70.25.68.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quicksilver.road.mcmartin.ca", Issuer "There Is No Cabal Certificate Authority" (verified OK))
	by fattire.cabal.ca (Postfix) with ESMTP id A6B8E23E83
	for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2006 19:09:35 -0500 (EST)
Date: Mon, 23 Jan 2006 19:07:53 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: [RFC] is_compat_task helper
Message-ID: <20060124000753.GC5604@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

As many people have noticed, there's a growing need for some
generic code to know if a task is being run under 32 on 64 or
other such situations requiring compat conversions. Adding
the is_compat_task() macro provides a nice way to abstract this,
which is currently a mess of #ifdef (CONFIG_ARCH1) #else (CONFIG_ARCH2)
(see drivers/input/evdev.c for example). Arch maintainers are free
to override the default __is_compat_task() macro in their asm/compat.h
headers to be correct for their arch. This provides generic code with a
way to get what it wants, without needing to know ugly per-arch
details.

[Not only does this nicely clean up generic code, it's also useful
 to clean up some ugliness in the per-arch signal, ptrace, etc., code.]

See http://lkml.org/lkml/2006/1/8/170 for an example of generic code
that can be nicely cleaned up this way.

Based on prior work by Carlos O'Donell <carlos@parisc-linux.org>

Signed-off-by: Carlos O'Donell <carlos@parisc-linux.org>
Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

diff --git a/include/linux/compat.h b/include/linux/compat.h
index f9ca534..1645200 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -6,10 +6,16 @@
  */
 #include <linux/config.h>
 
-#ifdef CONFIG_COMPAT
+#ifndef CONFIG_COMPAT
+
+/* No tasks needing compat if !CONFIG_COMPAT */
+#define __is_compat_task(x)	0
+
+#else
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/personality.h>	/* Conditional process compat */
 #include <linux/sem.h>
 
 #include <asm/compat.h>
@@ -18,6 +24,11 @@
 #define compat_jiffies_to_clock_t(x)	\
 		(((unsigned long)(x) * COMPAT_USER_HZ) / HZ)
 
+/* Arches may override __is_compat_task from asm/compat.h */
+#ifndef __is_compat_task
+#define __is_compat_task(x)	(personality(x->personality) == PER_LINUX32)
+#endif /* __is_compat_task */
+
 typedef __compat_uid32_t	compat_uid_t;
 typedef __compat_gid32_t	compat_gid_t;
 
@@ -162,4 +173,10 @@ int get_compat_sigevent(struct sigevent 
 		const struct compat_sigevent __user *u_event);
 
 #endif /* CONFIG_COMPAT */
+
+static inline int
+is_compat_task(struct task_struct *task) {
+	return __is_compat_task(task);
+}
+
 #endif /* _LINUX_COMPAT_H */
