From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 6/7] kprobes/arm: Fix %p uses in error messages
Date: Sat, 28 Apr 2018 21:37:33 +0900
Message-ID: <152491905361.9916.15300852365956231645.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fix %p uses in error messages by removing it and
using general dumper.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 arch/arm/probes/kprobes/core.c      |   10 +++++-----
 arch/arm/probes/kprobes/test-core.c |    1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index e90cc8a08186..e90165a56620 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -289,8 +289,8 @@ void __kprobes kprobe_handler(struct pt_regs *regs)
 				break;
 			case KPROBE_REENTER:
 				/* A nested probe was hit in FIQ, it is a BUG */
-				pr_warn("Unrecoverable kprobe detected at %p.\n",
-					p->addr);
+				pr_warn("Unrecoverable kprobe detected.\n");
+				dump_kprobe(p);
 				/* fall through */
 			default:
 				/* impossible cases */
@@ -615,11 +615,11 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 		if (orig_sp != stack_addr) {
 			struct pt_regs *saved_regs =
 				(struct pt_regs *)kcb->jprobe_saved_regs.ARM_sp;
-			printk("current sp %lx does not match saved sp %lx\n",
+			pr_err("current sp %lx does not match saved sp %lx\n",
 			       orig_sp, stack_addr);
-			printk("Saved registers for jprobe %p\n", jp);
+			pr_err("Saved registers for jprobe\n");
 			show_regs(saved_regs);
-			printk("Current registers\n");
+			pr_err("Current registers\n");
 			show_regs(regs);
 			BUG();
 		}
diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 9ed0129bed3c..b5c892e24244 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -1460,7 +1460,6 @@ static bool check_test_results(void)
 	print_registers(&result_regs);
 
 	if (mem) {
-		pr_err("current_stack=%p\n", current_stack);
 		pr_err("expected_memory:\n");
 		print_memory(expected_memory, mem_size);
 		pr_err("result_memory:\n");
