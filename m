From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v6 22/27] sh: kprobes: Don't call the ->break_handler() in SH kprobes code
Date: Wed, 20 Jun 2018 01:14:47 +0900
Message-ID: <152942488763.15209.7791710414058030809.stgit@devbox>
References: <152942424698.15209.15245996287444292393.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152942424698.15209.15245996287444292393.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Don't call the ->break_handler() from the SH kprobes code,
because it was only used by jprobes which got removed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
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
