Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbeAYFa4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:30:56 -0500
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 8/8] kprobes/s390: Fix %p uses in error messages
Date: Thu, 25 Jan 2018 14:30:32 +0900
Message-ID: <151685823207.3099.1804053958699756937.stgit@devbox>
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20180125053032.piKS_4XkOkcpzoR7EbW7i6Le0FbognFBPzjjVN35_nw@z>

Remove %p because the kprobe will be dumped in
dump_kprobe().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/s390/kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index af3722c28fd9..df30e5b9a572 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -282,7 +282,7 @@ static void kprobe_reenter_check(struct kprobe_ctlblk *kcb, struct kprobe *p)
 		 * is a BUG. The code path resides in the .kprobes.text
 		 * section and is executed with interrupts disabled.
 		 */
-		printk(KERN_EMERG "Invalid kprobe detected at %p.\n", p->addr);
+		pr_err("Invalid kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 	}
