From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 7/7] kprobes/arm64: Fix %p uses in error messages
Date: Sat, 28 Apr 2018 21:38:04 +0900
Message-ID: <152491908405.9916.12425053035317241111.stgit@devbox>
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

Fix %p uses in error messages by removing it because
those are redundant or meaningless.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: stable@vger.kernel.org
---
 arch/arm64/kernel/probes/kprobes.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d849d9804011..34f78d07a068 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -275,7 +275,7 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
+		pr_warn("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
@@ -521,7 +521,7 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 		    (struct pt_regs *)kcb->jprobe_saved_regs.sp;
 		pr_err("current sp %lx does not match saved sp %lx\n",
 		       orig_sp, stack_addr);
-		pr_err("Saved registers for jprobe %p\n", jp);
+		pr_err("Saved registers for jprobe\n");
 		__show_regs(saved_regs);
 		pr_err("Current registers\n");
 		__show_regs(regs);
