From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 23/27] sparc64: kprobes: Don't call the ->break_handler() in sparc64 kprobes code
Date: Mon, 28 May 2018 16:11:07 +0900
Message-ID: <152749146708.15132.8507553815561806162.stgit@devbox>
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

Don't call the ->break_handler() from the sparc64 kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/sparc/kernel/kprobes.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index f555711da8f1..c684c96ef2e9 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -147,18 +147,12 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			kcb->kprobe_status = KPROBE_REENTER;
 			prepare_singlestep(p, regs, kcb);
 			return 1;
-		} else {
-			if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
+		} else if (*(u32 *)addr != BREAKPOINT_INSTRUCTION) {
 			/* The breakpoint instruction was removed by
 			 * another cpu right after we hit, no further
 			 * handling of this interrupt is appropriate
 			 */
-				ret = 1;
-				goto no_kprobe;
-			}
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs))
-				goto ss_probe;
+			ret = 1;
 		}
 		goto no_kprobe;
 	}
@@ -184,7 +178,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs, kcb);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
