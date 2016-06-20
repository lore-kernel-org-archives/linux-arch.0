Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58720 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbcFTXpP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jun 2016 19:45:15 -0400
From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 07/13] x86/die: Don't try to recover from an OOPS on a non-default stack
Date: Mon, 20 Jun 2016 16:43:37 -0700
Message-ID: <fd7802cca49809aef2c6d87b52ca6e75ee5aad99.1466466093.git.luto@kernel.org>
In-Reply-To: <cover.1466466093.git.luto@kernel.org>
References: <cover.1466466093.git.luto@kernel.org>
In-Reply-To: <cover.1466466093.git.luto@kernel.org>
References: <cover.1466466093.git.luto@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
Message-ID: <20160620234337.XHl53zlBScq5pnauWIFi-btFlY36LsRIs9ezMypxIRw@z>

It's not going to work, because the scheduler will explode if we try
to schedule when running on an IST stack or similar.

This will matter when we let kernel stack overflows (which are #DF)
call die().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 2bb25c3fe2e8..36effb39c9c9 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -247,6 +247,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 		return;
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
+	if (((current_stack_pointer() ^ (current_top_of_stack() - 1))
+	     & ~(THREAD_SIZE - 1)) != 0)
+		panic("Fatal exception on special stack");
 	if (panic_on_oops)
 		panic("Fatal exception");
 	do_exit(signr);
-- 
2.5.5

