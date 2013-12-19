From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH -tip v6 03/22] [BUGFIX] kprobes/x86: Prohibit probing on debug_stack_*
Date: Thu, 19 Dec 2013 09:04:01 +0000
Message-ID: <20131219090401.14309.40254.stgit@kbuild-fedora.novalocal>
References: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <systemtap-return-21806-gls-systemtap=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:systemtap-unsubscribe-##L=##H@sourceware.org>
List-Subscribe: <mailto:systemtap-subscribe@sourceware.org>
List-Post: <mailto:systemtap@sourceware.org>
List-Help: <mailto:systemtap-help@sourceware.org>, <http://sourceware.org/lists.html#faqs>
Sender: systemtap-owner@sourceware.org
In-Reply-To: <20131219090353.14309.15496.stgit@kbuild-fedora.novalocal>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Sandeepa Prabhu <sandeepa.prabhu@linaro.org>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, systemtap@sourceware.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Prohibit probing on debug_stack_reset and debug_stack_set_zero.
Since the both functions are called from TRACE_IRQS_ON/OFF_DEBUG
macros which run in int3 ist entry, probing it may cause a soft
lockup.

This happens when the kernel built with CONFIG_DYNAMIC_FTRACE=y
and CONFIG_TRACE_IRQFLAGS=y.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Seiji Aguchi <seiji.aguchi@hds.com>
---
 arch/x86/kernel/cpu/common.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 6abc172..220de22 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -8,6 +8,7 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/init.h>
+#include <linux/kprobes.h>
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 #include <linux/io.h>
@@ -1153,6 +1154,7 @@ int is_debug_stack(unsigned long addr)
 		(addr <= __get_cpu_var(debug_stack_addr) &&
 		 addr > (__get_cpu_var(debug_stack_addr) - DEBUG_STKSZ));
 }
+NOKPROBE_SYMBOL(is_debug_stack);
 
 DEFINE_PER_CPU(u32, debug_idt_ctr);
 
@@ -1161,6 +1163,7 @@ void debug_stack_set_zero(void)
 	this_cpu_inc(debug_idt_ctr);
 	load_current_idt();
 }
+NOKPROBE_SYMBOL(debug_stack_set_zero);
 
 void debug_stack_reset(void)
 {
@@ -1169,6 +1172,7 @@ void debug_stack_reset(void)
 	if (this_cpu_dec_return(debug_idt_ctr) == 0)
 		load_current_idt();
 }
+NOKPROBE_SYMBOL(debug_stack_reset);
 
 #else	/* CONFIG_X86_64 */
 
