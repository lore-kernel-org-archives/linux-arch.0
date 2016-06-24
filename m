From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 10/16] x86/die: Don't try to recover from an OOPS on a non-default stack
Date: Thu, 23 Jun 2016 21:23:05 -0700
Message-ID: <66fc0e6c5a47a0bb8e96c340908067c72a027acc.1466741835.git.luto@kernel.org>
References: <cover.1466741835.git.luto@kernel.org>
Reply-To: kernel-hardening@lists.openwall.com
Return-path: <kernel-hardening-return-3632-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <cover.1466741835.git.luto@kernel.org>
In-Reply-To: <cover.1466741835.git.luto@kernel.org>
References: <cover.1466741835.git.luto@kernel.org>
To: x86@kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-arch.vger.kernel.org

It's not going to work, because the scheduler will explode if we try
to schedule when running on an IST stack or similar.

This will matter when we let kernel stack overflows (which are #DF)
call die().

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index d6209f3a69cb..70d5aae8b8f7 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -245,6 +245,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
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
