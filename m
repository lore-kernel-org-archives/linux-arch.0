Return-Path: <bjorn.helgaas@hp.com>
Received: from atlrel6.hp.com ([156.153.255.205]:16845 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262011AbUCDRBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Mar 2004 12:01:44 -0500
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.11.136.119])
	by atlrel6.hp.com (Postfix) with ESMTP id D6CA91C02214
	for <linux-arch@vger.kernel.org>; Thu,  4 Mar 2004 12:01:43 -0500 (EST)
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: disable_hlt()/enable_hlt() look racy
Date: Thu, 4 Mar 2004 10:01:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403041001.42725.bjorn.helgaas@hp.com>
To: linux-arch@vger.kernel.org
Cc: Alex Williamson <awilliam@fc.hp.com>
List-ID: <linux-arch.vger.kernel.org>

Alex Williamson implemented disable_hlt()/enable_hlt() for ia64,
and in the process, we noticed that the implementations on
other architectures look racy because hlt_counter is not
protected.

Currently arm, arm26, cris, i386, parisc, sh, um, and x86_64
implement these, and all except um look suspicious.  Here
is the current proposal for ia64:

----------  Forwarded Message  ----------

Subject: RE: [PATCH] more robust halt_light
Date: Wednesday 03 March 2004 3:31 pm
From: Alex Williamson <alex.williamson@hp.com>
To: linux-ia64@vger.kernel.org
...
===== arch/ia64/kernel/process.c 1.51 vs edited =====
--- 1.51/arch/ia64/kernel/process.c	Sat Feb 28 03:02:47 2004
+++ edited/arch/ia64/kernel/process.c	Wed Mar  3 14:58:24 2004
@@ -39,6 +39,8 @@
 
 #include "sigframe.h"
 
+static atomic_t hlt_counter = ATOMIC_INIT(0);
+
 void (*ia64_mark_idle)(int);
 
 
@@ -159,6 +161,20 @@
 		ia64_do_signal(oldset, scr, in_syscall);
 }
 
+void disable_hlt(void)
+{
+	atomic_inc(&hlt_counter);
+}
+
+EXPORT_SYMBOL(disable_hlt);
+
+void enable_hlt(void)
+{
+	atomic_dec(&hlt_counter);
+}
+
+EXPORT_SYMBOL(enable_hlt);
+
 /*
  * We use this if we don't have any better idle routine..
  */
@@ -166,7 +182,7 @@
 default_idle (void)
 {
 #ifdef CONFIG_IA64_PAL_IDLE
-	if (!need_resched())
+	if (!atomic_read(&hlt_counter) && local_cpu_data->hlt_works_ok && !need_resched())
 		safe_halt();
 #endif
 }
