Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966650AbeFSQOm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Jun 2018 12:14:42 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 21/27] s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
Date: Wed, 20 Jun 2018 01:14:18 +0900
Message-ID: <152942485849.15209.16608277783809018031.stgit@devbox>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Message-ID: <20180619161418.Oi-FqgKMuft1JYE1N39h-V83LVyn_kO7-0CDfyJzMDM@z>

Don't call the ->break_handler() from the s390 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/kprobes.c |   20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 0967de19f53d..3e34018960b5 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -332,26 +332,6 @@ static int kprobe_handler(struct pt_regs *regs)
 		}
 		enable_singlestep(kcb, regs, (unsigned long) p->ainsn.insn);
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			/*
-			 * Continuation after the jprobe completed and
-			 * caused the jprobe_return trap. The jprobe
-			 * break_handler "returns" to the original
-			 * function that still has the kprobe breakpoint
-			 * installed. We continue with single stepping.
-			 */
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			enable_singlestep(kcb, regs,
-					  (unsigned long) p->ainsn.insn);
-			return 1;
-		} /* else:
-		   * No kprobe at this address and the current kprobe
-		   * has no break handler (no jprobe!). The kernel just
-		   * exploded, let the standard trap handler pick up the
-		   * pieces.
-		   */
 	} /* else:
 	   * No kprobe at this address and no active kprobe. The trap has
 	   * not been caused by a kprobe breakpoint. The race of breakpoint
