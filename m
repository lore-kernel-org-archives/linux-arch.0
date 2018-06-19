From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 16/27] ARM: kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Wed, 20 Jun 2018 01:11:53 +0900
Message-ID: <152942471328.15209.10625693210204476080.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/probes/kprobes/core.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 23562111c511..3192350f389d 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -315,17 +315,6 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				reset_current_kprobe();
 			}
 		}
-	} else if (cur) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur->break_handler && cur->break_handler(cur, regs)) {
-			kcb->kprobe_status = KPROBE_HIT_SS;
-			singlestep(cur, regs, kcb);
-			if (cur->post_handler) {
-				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				cur->post_handler(cur, regs, 0);
-			}
-		}
-		reset_current_kprobe();
 	} else {
 		/*
 		 * The probe was removed and a race is in progress.
