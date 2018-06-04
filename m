Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750723AbeFDP6g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 Jun 2018 11:58:36 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 20/27] MIPS: kprobes: Don't call the ->break_handler() in MIPS kprobes code
Date: Tue,  5 Jun 2018 00:58:12 +0900
Message-ID: <152812789186.10068.4347487945198034534.stgit@devbox>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Message-ID: <20180604155812.4uf0xnkIYpMXyoFfcZlPdBNDwNhxHUR2goiNzdUvuwY@z>

Don't call the ->break_handler() from the MIPS kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/kprobes.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index efdcd0b1ce12..7fd277bc59b9 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -326,19 +326,13 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 				preempt_enable_no_resched();
 			}
 			return 1;
-		} else {
-			if (addr->word != breakpoint_insn.word) {
-				/*
-				 * The breakpoint instruction was removed by
-				 * another cpu right after we hit, no further
-				 * handling of this interrupt is appropriate
-				 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+		} else if (addr->word != breakpoint_insn.word) {
+			/*
+			 * The breakpoint instruction was removed by
+			 * another cpu right after we hit, no further
+			 * handling of this interrupt is appropriate
+			 */
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -367,7 +361,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		return 1;
 	}
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	if (kcb->flags & SKIP_DELAYSLOT) {
 		kcb->kprobe_status = KPROBE_HIT_SSDONE;
