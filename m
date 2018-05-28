Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753756AbeE1HLC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 May 2018 03:11:02 -0400
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v4 22/27] sh: kprobes: Don't call the ->break_handler() in SH kprobes code
Date: Mon, 28 May 2018 16:10:36 +0900
Message-ID: <152749143600.15132.3715538903929976134.stgit@devbox>
In-Reply-To: <152749074878.15132.16693721906742461289.stgit@devbox>
References: <152749074878.15132.16693721906742461289.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, Laura Abbott <labbott@redhat.com>, Josef Bacik <jbacik@fb.com>, Alexei Starovoitov <ast@kernel.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S . Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org
Message-ID: <20180528071036.7Tl-9Ul3YYfrAw7RmogLnwA_AQEblI5lG_lh1CgZdC0@z>

Don't call the ->break_handler() from the SH kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/sh/kernel/kprobes.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 2b5e58873b96..4fafe0cd12c6 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -248,11 +248,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 			prepare_singlestep(p, regs);
 			kcb->kprobe_status = KPROBE_REENTER;
 			return 1;
-		} else {
-			p = __this_cpu_read(current_kprobe);
-			if (p->break_handler && p->break_handler(p, regs)) {
-				goto ss_probe;
-			}
 		}
 		goto no_kprobe;
 	}
@@ -281,7 +276,6 @@ static int __kprobes kprobe_handler(struct pt_regs *regs)
 		/* handler has already set things up, so skip ss setup */
 		return 1;
 
-ss_probe:
 	prepare_singlestep(p, regs);
 	kcb->kprobe_status = KPROBE_HIT_SS;
 	return 1;
@@ -508,14 +502,8 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
 				if (post_kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
 			} else {
-				if (kprobe_handler(args->regs)) {
+				if (kprobe_handler(args->regs))
 					ret = NOTIFY_STOP;
-				} else {
-					p = __this_cpu_read(current_kprobe);
-					if (p->break_handler &&
-					    p->break_handler(p, args->regs))
-						ret = NOTIFY_STOP;
-				}
 			}
 		}
 	}
