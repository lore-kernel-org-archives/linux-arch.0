Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:60226 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWAnJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 20:43:09 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:05 -0500
Message-ID: <20190523003916.20726-16-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 15/26] signal/nds32: Remove tsk parameter from send_sigtrap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003905.QmjKGptuH8L91WxSRvp9dYMUPP8WUYeNjPlDBjXaCL4@z>

The send_sigtrap function is always called with tsk == current.
Make that obvious by removing the tsk parameter.

This also makes it clear that send_sigtrap always calls
force_sig_fault on the current task.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/nds32/kernel/traps.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 8d84b8b30eb6..66f197efcec9 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -255,9 +255,10 @@ void __init early_trap_init(void)
 	cpu_cache_wbinval_page(base, true);
 }
 
-void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs,
-		  int error_code, int si_code)
+static void send_sigtrap(struct pt_regs *regs, int error_code, int si_code)
 {
+	struct task_struct *tsk = current;
+
 	tsk->thread.trap_no = ENTRY_DEBUG_RELATED;
 	tsk->thread.error_code = error_code;
 
@@ -274,7 +275,7 @@ void do_debug_trap(unsigned long entry, unsigned long addr,
 
 	if (user_mode(regs)) {
 		/* trap_signal */
-		send_sigtrap(current, regs, 0, TRAP_BRKPT);
+		send_sigtrap(regs, 0, TRAP_BRKPT);
 	} else {
 		/* kernel_trap */
 		if (!fixup_exception(regs))
-- 
2.21.0
