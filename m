From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 7/8] kprobes/MN10300: Fix %p uses in error messages
Date: Thu, 25 Jan 2018 14:30:02 +0900
Message-ID: <151685820218.3099.4909961842360559942.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750972AbeAYFa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:30:27 -0500
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

Replace %p with %px because it is right before BUG().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/mn10300/kernel/kprobes.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mn10300/kernel/kprobes.c b/arch/mn10300/kernel/kprobes.c
index 0311a7fcea16..e539fac00321 100644
--- a/arch/mn10300/kernel/kprobes.c
+++ b/arch/mn10300/kernel/kprobes.c
@@ -632,9 +632,9 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 
 	if (addr == (u8 *) jprobe_return_bp_addr) {
 		if (jprobe_saved_regs_location != regs) {
-			printk(KERN_ERR"JPROBE:"
-			       " Current regs (%p) does not match saved regs"
-			       " (%p).\n",
+			pr_err("JPROBE:"
+			       " Current regs (%px) does not match saved regs"
+			       " (%px).\n",
 			       regs, jprobe_saved_regs_location);
 			BUG();
 		}
