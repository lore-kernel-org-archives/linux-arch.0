Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:57692 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758225Ab3KOEyM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2013 23:54:12 -0500
Subject: [PATCH -tip RFC v2 18/22] x86/dumpstack: Use NOKPROBE_SYMBOL macro
 in dumpstack.c
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Date: Fri, 15 Nov 2013 04:54:08 +0000
Message-ID: <20131115045408.27580.10378.stgit@kbuild-fedora.novalocal>
In-Reply-To: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
References: <20131115045312.27580.95902.stgit@kbuild-fedora.novalocal>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-arch@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, x86@kernel.org, lkml <linux-kernel@vger.kernel.org>, "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.cz>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20131115045408.gBfybg5hxIBf7W-a47QrXP37Vmy5BN999mFu9ziaU6A@z>

Use NOKPROBE_SYMBOL macro for protecting functions
from kprobes instead of __kprobes annotation in
dumpstack.c.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Tejun Heo <tj@kernel.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
---
 arch/x86/kernel/dumpstack.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index d9c12d3..b74ebc7 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -200,7 +200,7 @@ static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
 static int die_owner = -1;
 static unsigned int die_nest_count;
 
-unsigned __kprobes long oops_begin(void)
+unsigned long oops_begin(void)
 {
 	int cpu;
 	unsigned long flags;
@@ -223,8 +223,9 @@ unsigned __kprobes long oops_begin(void)
 	return flags;
 }
 EXPORT_SYMBOL_GPL(oops_begin);
+NOKPROBE_SYMBOL(oops_begin);
 
-void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
+void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 {
 	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
@@ -247,8 +248,9 @@ void __kprobes oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 		panic("Fatal exception");
 	do_exit(signr);
 }
+NOKPROBE_SYMBOL(oops_end);
 
-int __kprobes __die(const char *str, struct pt_regs *regs, long err)
+int __die(const char *str, struct pt_regs *regs, long err)
 {
 #ifdef CONFIG_X86_32
 	unsigned short ss;
@@ -291,6 +293,7 @@ int __kprobes __die(const char *str, struct pt_regs *regs, long err)
 #endif
 	return 0;
 }
+NOKPROBE_SYMBOL(__die);
 
 /*
  * This is gone through when something in the kernel has done something bad

