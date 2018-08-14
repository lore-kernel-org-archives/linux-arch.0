Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:51598 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeHNUNW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2018 16:13:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.18 03/79] kprobes/x86: Fix %p uses in error messages
Date: Tue, 14 Aug 2018 19:16:22 +0200
Message-ID: <20180814171336.924800339@linuxfoundation.org>
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jon Medhurst <tixy@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Richter <tmricht@linux.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Will Deacon <will.deacon@arm.com>, acme@kernel.org, akpm@linux-foundation.org, brueckner@linux.vnet.ibm.com, linux-arch@vger.kernel.org, rostedt@goodmis.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@kernel.org>
Message-ID: <20180814171622.Iv_IVMWbeM004qgm5NNmrD0FTgqKL_r9Flj5S31A5k8@z>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0ea063306eecf300fcf06d2f5917474b580f666f upstream.

Remove all %p uses in error messages in kprobes/x86.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Tobin C . Harding <me@tobin.cc>
Cc: Will Deacon <will.deacon@arm.com>
Cc: acme@kernel.org
Cc: akpm@linux-foundation.org
Cc: brueckner@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/lkml/152491902310.9916.13355297638917767319.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kprobes/core.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -395,8 +395,6 @@ int __copy_instruction(u8 *dest, u8 *src
 			  - (u8 *) real;
 		if ((s64) (s32) newdisp != newdisp) {
 			pr_err("Kprobes error: new displacement does not fit into s32 (%llx)\n", newdisp);
-			pr_err("\tSrc: %p, Dest: %p, old disp: %x\n",
-				src, real, insn->displacement.value);
 			return 0;
 		}
 		disp = (u8 *) dest + insn_offset_displacement(insn);
@@ -640,8 +638,7 @@ static int reenter_kprobe(struct kprobe
 		 * Raise a BUG or we'll continue in an endless reentering loop
 		 * and eventually a stack overflow.
 		 */
-		printk(KERN_WARNING "Unrecoverable kprobe detected at %p.\n",
-		       p->addr);
+		pr_err("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 	default:
