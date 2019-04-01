Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfDANoW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 09:44:22 -0400
Message-ID: <20190401134421.121919570@goodmis.org>
Date: Mon, 01 Apr 2019 09:41:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/6 v3] csky: Fix syscall_get_arguments() and syscall_set_arguments()
References: <20190401134104.676620247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Will Drewry <wad@chromium.org>, Guo Ren <guoren@kernel.org>
Message-ID: <20190401134108.Bue3nLvV16L7XjiWlvpl-RQVWgmUhRrj1jzg-ACXAR4@z>

From: "Dmitry V. Levin" <ldv@altlinux.org>

C-SKY syscall arguments are located in orig_a0,a1,a2,a3,regs[0],regs[1]
fields of struct pt_regs.

Due to an off-by-one bug and a bug in pointer arithmetic
syscall_get_arguments() was reading orig_a0,regs[1..5] fields instead.
Likewise, syscall_set_arguments() was writing orig_a0,regs[1..5] fields
instead.

Link: http://lkml.kernel.org/r/20190329171230.GB32456@altlinux.org

Fixes: 4859bfca11c7d ("csky: System Call")
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/csky/include/asm/syscall.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/syscall.h b/arch/csky/include/asm/syscall.h
index d637445737b7..9a9cd81e66c1 100644
--- a/arch/csky/include/asm/syscall.h
+++ b/arch/csky/include/asm/syscall.h
@@ -49,10 +49,11 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
 	if (i == 0) {
 		args[0] = regs->orig_a0;
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(args, &regs->a1 + i * sizeof(regs->a1), n * sizeof(args[0]));
+	memcpy(args, &regs->a1 + i, n * sizeof(args[0]));
 }
 
 static inline void
@@ -63,10 +64,11 @@ syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 	if (i == 0) {
 		regs->orig_a0 = args[0];
 		args++;
-		i++;
 		n--;
+	} else {
+		i--;
 	}
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
 }
 
 static inline int
-- 
2.20.1
