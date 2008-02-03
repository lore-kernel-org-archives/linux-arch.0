Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.191]:4963 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764968AbYBCDAQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Feb 2008 22:00:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1143251rvb.1
        for <linux-arch@vger.kernel.org>; Sat, 02 Feb 2008 19:00:16 -0800 (PST)
Subject: [PATCH 2/2] kprobe: remove preempt_enable/disable from
	kprobe_handle_fault()
From: Harvey Harrison <harvey.harrison@gmail.com>
Content-Type: text/plain
Date: Sat, 02 Feb 2008 19:00:26 -0800
Message-Id: <1202007626.1844.46.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This patch removes the preempt_disable/enable pair around kprobe_running
which was originally added to avoid the assertion from smp_processor_id
which would be hit an asertion if preemption was enabled.

Kprobes can not be running if we are preemptible, so test explicitly
for preemption and bail out before hitting kprobe_running().

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/linux/kprobes.h |   19 ++++++++-----------
 1 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e5ecb1e..e099426 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -213,19 +213,16 @@ static inline struct kprobe *kprobe_running(void)
 	return (__get_cpu_var(current_kprobe));
 }
 
+/*
+ * If it is a kprobe pagefault we can not be preemptible so return before
+ * calling kprobe_running() as it will assert on smp_processor_id if
+ * preemption is enabled.
+ */
 static inline int kprobe_handle_fault(struct pt_regs *regs, int trapnr)
 {
-	int ret = 0;
-
-	/* kprobe_running() needs smp_processor_id() */
-	if (!user_mode(regs)) {
-		preempt_disable();
-		if (kprobe_running() && kprobe_fault_handler(regs, trapnr))
-			ret = 1;
-		preempt_enable();
-	}
-
-	return ret;
+	if (!user_mode(regs) && !preemptible() && kprobe_running())
+		return kprobe_fault_handler(regs, trapnr);
+	return 0;
 }
 
 static inline void reset_current_kprobe(void)
-- 
1.5.4.rc4.1142.gf5a97

