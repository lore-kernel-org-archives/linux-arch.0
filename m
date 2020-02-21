From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 03/27] x86/entry: Flip _TIF_SIGPENDING and _TIF_NOTIFY_RESUME handling
Date: Fri, 21 Feb 2020 14:34:19 +0100
Message-ID: <20200221134215.206604505@infradead.org>
References: <20200221133416.777099322@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:56358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgBUNud (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:33 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org

Make sure we run task_work before we hit any kind of userspace -- very
much including signals.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c                   |    8 
 usr/src/linux-2.6/arch/x86/entry/common.c |  440 ------------------------------
 2 files changed, 4 insertions(+), 444 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -155,16 +155,16 @@ static void exit_to_usermode_loop(struct
 		if (cached_flags & _TIF_PATCH_PENDING)
 			klp_update_patch_state(current);
 
-		/* deal with pending signal delivery */
-		if (cached_flags & _TIF_SIGPENDING)
-			do_signal(regs);
-
 		if (cached_flags & _TIF_NOTIFY_RESUME) {
 			clear_thread_flag(TIF_NOTIFY_RESUME);
 			tracehook_notify_resume(regs);
 			rseq_handle_notify_resume(NULL, regs);
 		}
 
+		/* deal with pending signal delivery */
+		if (cached_flags & _TIF_SIGPENDING)
+			do_signal(regs);
+
 		if (cached_flags & _TIF_USER_RETURN_NOTIFY)
 			fire_user_return_notifiers();
 
