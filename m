Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.hitachi.co.jp ([133.145.228.50]:46366 "EHLO
	mailxx.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab3KOE6w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2013 23:58:52 -0500
Subject: [PATCH -tip RFC v2 15/22] x86/alternative: Use NOKPROBE_SYMBOL
 macro in alternative.c
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Fri, 15 Nov 2013 04:54:00 +0000
Message-ID: <20131115045359.27580.45302.stgit@kbuild-fedora.novalocal>
In-Reply-To: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131115045400.bmp_apl1LJcdRXr4enPLysSaHR9OfNad_6H9w0b2BAE@z>

Use NOKPROBE_SYMBOL macro to protect functions from kprobes
instead of __kprobes annotation in alternative.c.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index df94598..7cfd6d7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -551,7 +551,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
  *
  * Note: Must be called under text_mutex.
  */
-void *__kprobes text_poke(void *addr, const void *opcode, size_t len)
+void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	unsigned long flags;
 	char *vaddr;
@@ -585,6 +585,7 @@ void *__kprobes text_poke(void *addr, const void *opcode, size_t len)
 	local_irq_restore(flags);
 	return addr;
 }
+NOKPROBE_SYMBOL(text_poke);
 
 static void do_sync_core(void *info)
 {

