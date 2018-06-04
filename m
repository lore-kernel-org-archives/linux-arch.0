Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbeFDP7F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:59:05 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 21/27] s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
Date: Tue,  5 Jun 2018 00:58:41 +0900
Message-ID: <152812792088.10068.655430820863308741.stgit@devbox>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Message-ID: <20180604155841.T0A62Dfjb7wU_GkeulwuPU-E97gVHH5QaHDsV_d_GpY@z>

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
