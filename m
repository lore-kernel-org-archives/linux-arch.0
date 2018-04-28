From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 5/7] kprobes/x86: Fix %p uses in error messages
Date: Sat, 28 Apr 2018 21:37:03 +0900
Message-ID: <152491902310.9916.13355297638917767319.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Remove all %p uses in error messages in kprobes/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Just remove %p.
 Changes in v3:
  - Do not use %px.
---
 arch/x86/kernel/kprobes/core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..2c7ec4ae660c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -391,8 +391,6 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			  - (u8 *) real;
 		if ((s64) (s32) newdisp != newdisp) {
 			pr_err("Kprobes error: new displacement does not fit into s32 (%llx)\n", newdisp);
-			pr_err("\tSrc: %p, Dest: %p, old disp: %x\n",
-				src, real, insn->displacement.value);
 			return 0;
 		}
 		disp = (u8 *) dest + insn_offset_displacement(insn);
@@ -636,8 +634,7 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 		 * Raise a BUG or we'll continue in an endless reentering loop
 		 * and eventually a stack overflow.
 		 */
-		printk(KERN_WARNING "Unrecoverable kprobe detected at %p.\n",
-		       p->addr);
+		pr_err("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 	default:
@@ -1146,12 +1143,10 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	    (addr < (u8 *) jprobe_return_end)) {
 		if (stack_addr(regs) != saved_sp) {
 			struct pt_regs *saved_regs = &kcb->jprobe_saved_regs;
-			printk(KERN_ERR
-			       "current sp %p does not match saved sp %p\n",
-			       stack_addr(regs), saved_sp);
-			printk(KERN_ERR "Saved registers for jprobe %p\n", jp);
+			pr_err("current %%sp does not match saved %%sp\n");
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk(KERN_ERR "Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
