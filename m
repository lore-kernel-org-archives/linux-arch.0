From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH -tip v5 17/27] arm64: kprobes: Don't call the ->break_handler() in arm kprobes code
Date: Tue,  5 Jun 2018 00:56:44 +0900
Message-ID: <152812780433.10068.4191004481518140821.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Don't call the ->break_handler() from the arm kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/kernel/probes/kprobes.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 3ca2351109a6..076c3c0775a6 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -408,14 +408,6 @@ static void __kprobes kprobe_handler(struct pt_regs *regs)
 				return;
 			}
 		}
-	} else if ((le32_to_cpu(*(kprobe_opcode_t *) addr) ==
-	    BRK64_OPCODE_KPROBES) && cur_kprobe) {
-		/* We probably hit a jprobe.  Call its break handler. */
-		if (cur_kprobe->break_handler  &&
-		     cur_kprobe->break_handler(cur_kprobe, regs)) {
-			setup_singlestep(cur_kprobe, regs, kcb, 0);
-			return;
-		}
 	}
 	/*
 	 * The breakpoint instruction was removed right
