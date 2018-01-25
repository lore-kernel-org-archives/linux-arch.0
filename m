From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 6/8] kprobes/arm64: Fix %p uses in error messages
Date: Thu, 25 Jan 2018 14:29:32 +0900
Message-ID: <151685817205.3099.18079175391687728067.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751238AbeAYF35 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:29:57 -0500
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

Fix %p uses in error messages by removing it because
those are redundant or meaningless.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
