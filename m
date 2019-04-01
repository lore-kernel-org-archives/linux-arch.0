Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfDANoW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 09:44:22 -0400
Message-ID: <20190401134420.958530155@goodmis.org>
Date: Mon, 01 Apr 2019 09:41:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and syscall_set_arguments()
References: <20190401134104.676620247@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>, Will Drewry <wad@chromium.org>, Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Message-ID: <20190401134107.EQkhpu8SX6HlbLf_jj4G2eIyK5jDaGlX4t-2AXRIX7o@z>

From: "Dmitry V. Levin" <ldv@altlinux.org>

RISC-V syscall arguments are located in orig_a0,a1..a5 fields
of struct pt_regs.

Due to an off-by-one bug and a bug in pointer arithmetic
syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
Likewise, syscall_set_arguments() was writing s3..s7 fields
instead of a1..a5.

Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org

Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/riscv/include/asm/syscall.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index bba3da6ef157..6ea9e1804233 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -79,10 +79,11 @@ static inline void syscall_get_arguments(struct task_struct *task,
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
 
 static inline void syscall_set_arguments(struct task_struct *task,
@@ -94,10 +95,11 @@ static inline void syscall_set_arguments(struct task_struct *task,
         if (i == 0) {
                 regs->orig_a0 = args[0];
                 args++;
-                i++;
                 n--;
-        }
-	memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
+	} else {
+		i--;
+	}
+	memcpy(&regs->a1 + i, args, n * sizeof(regs->a1));
 }
 
 static inline int syscall_get_arch(void)
-- 
2.20.1
