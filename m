Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966661AbeFSQLs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Jun 2018 12:11:48 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 15/27] ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
Date: Wed, 20 Jun 2018 01:11:24 +0900
Message-ID: <152942468446.15209.13773902741600803798.stgit@devbox>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org
Message-ID: <20180619161124.wDarawUCMGHha20XNox89bKshOtP0OesWQgXT-nKN0Q@z>

Don't call the ->break_handler() from the ARC kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
---
 arch/arc/kernel/kprobes.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 7811a6bbe8f0..465365696c91 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -234,13 +234,6 @@ int __kprobes arc_kprobe_handler(unsigned long addr, struct pt_regs *regs)
 		}
 
 		return 1;
-	} else if (kprobe_running()) {
-		p = __this_cpu_read(current_kprobe);
-		if (p->break_handler && p->break_handler(p, regs)) {
-			setup_singlestep(p, regs);
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			return 1;
-		}
 	}
 
 	/* no_kprobe: */
