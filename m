From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 15/27] ARC: kprobes: Don't call the ->break_handler() in ARC kprobes code
Date: Tue,  5 Jun 2018 00:55:46 +0900
Message-ID: <152812774641.10068.11144829855901255813.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
