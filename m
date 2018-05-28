From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 21/27] s390/kprobes: Don't call the ->break_handler() in s390 kprobes code
Date: Mon, 28 May 2018 16:10:04 +0900
Message-ID: <152749140479.15132.14122696148962136409.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
List-Id: linux-arch.vger.kernel.org

Don't call the ->break_handler() from the s390 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
