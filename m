From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v9 5/5] [BUGFIX] kprobes/x86: Do not jump-optimize kprobes on irq entry code
Date: Thu,  3 Aug 2017 11:39:26 +0900
Message-ID: <150172795654.27216.9824039077047777477.stgit@devbox>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <150172762859.27216.16741726568669538542.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since the kernel segment registers are not prepared at the
entry of irq-entry code, if a kprobe on such code is
jump-optimized, accessing per-cpu variables may cause
kernel panic.
However, if the kprobe is not optimized, it kicks int3
exception and set segment registers correctly.

This checks probe-address and if it is in irq-entry code,
it prohibits optimizing such kprobes. This means we can
continuously probing such interrupt handlers by kprobes
but it is not optimized anymore.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Tested-by: Francis Deslauriers <francis.deslauriers@efficios.com>
---
 arch/x86/kernel/kprobes/opt.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 69ea0bc1cfa3..4f98aad38237 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -39,6 +39,7 @@
 #include <asm/insn.h>
 #include <asm/debugreg.h>
 #include <asm/set_memory.h>
+#include <asm/sections.h>
 
 #include "common.h"
 
@@ -251,10 +252,12 @@ static int can_optimize(unsigned long paddr)
 
 	/*
 	 * Do not optimize in the entry code due to the unstable
-	 * stack handling.
+	 * stack handling and registers setup.
 	 */
-	if ((paddr >= (unsigned long)__entry_text_start) &&
-	    (paddr <  (unsigned long)__entry_text_end))
+	if (((paddr >= (unsigned long)__entry_text_start) &&
+	     (paddr <  (unsigned long)__entry_text_end)) ||
+	    ((paddr >= (unsigned long)__irqentry_text_start) &&
+	     (paddr <  (unsigned long)__irqentry_text_end)))
 		return 0;
 
 	/* Check there is enough space for a relative jump. */
