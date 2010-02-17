From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 1/5] seqlock: Fix up last oldstyle init users
Date: Wed, 17 Feb 2010 18:47:37 -0000
Message-ID: <20100217184155.772625805@linutronix.de>
References: <20100217183740.486724334@linutronix.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:42243 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab0BQSr4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Feb 2010 13:47:56 -0500
Content-Disposition: inline;
	filename=seqlock-fixup-last-oldstyle-init-users.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, John Stultz <johnstul@us.ibm.com>

The oldstyle init SEQLOCK_UNLOCKED circumvents lockdep. Convert the
last users to __SEQLOCK_UNLOCKED(lockname).

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/ia64/kernel/time.c         |    2 +-
 arch/x86/kernel/vsyscall_64.c   |    2 +-
 net/ipv4/inet_connection_sock.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6-tip/arch/ia64/kernel/time.c
===================================================================
--- linux-2.6-tip.orig/arch/ia64/kernel/time.c
+++ linux-2.6-tip/arch/ia64/kernel/time.c
@@ -36,7 +36,7 @@
 static cycle_t itc_get_cycles(struct clocksource *cs);
 
 struct fsyscall_gtod_data_t fsyscall_gtod_data = {
-	.lock = SEQLOCK_UNLOCKED,
+	.lock = __SEQLOCK_UNLOCKED(fsyscall_gtod_data.lock),
 };
 
 struct itc_jitter_data_t itc_jitter_data;
Index: linux-2.6-tip/arch/x86/kernel/vsyscall_64.c
===================================================================
--- linux-2.6-tip.orig/arch/x86/kernel/vsyscall_64.c
+++ linux-2.6-tip/arch/x86/kernel/vsyscall_64.c
@@ -59,7 +59,7 @@ int __vgetcpu_mode __section_vgetcpu_mod
 
 struct vsyscall_gtod_data __vsyscall_gtod_data __section_vsyscall_gtod_data =
 {
-	.lock = SEQLOCK_UNLOCKED,
+	.lock = __SEQLOCK_UNLOCKED(__vsyscall_gtod_data.lock),
 	.sysctl_enabled = 1,
 };
 
Index: linux-2.6-tip/net/ipv4/inet_connection_sock.c
===================================================================
--- linux-2.6-tip.orig/net/ipv4/inet_connection_sock.c
+++ linux-2.6-tip/net/ipv4/inet_connection_sock.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(inet_csk_timer_bug_msg);
  * This struct holds the first and last local port number.
  */
 struct local_ports sysctl_local_ports __read_mostly = {
-	.lock = SEQLOCK_UNLOCKED,
+	.lock = __SEQLOCK_UNLOCKED(local_ports_sysctl_local_ports.lock),
 	.range = { 32768, 61000 },
 };
 
