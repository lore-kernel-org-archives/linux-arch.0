From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 43/45] x86/sigreturn: use SYSCALL_DEFINE0
Date: Thu, 22 Mar 2018 10:00:57 +0100
Message-ID: <20180322090059.19361-44-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: "Tautschnig, Michael" <tautschn@amazon.co.uk>, Michael Tautschnig <tautschn@amazon.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Jaswinder Singh <jaswinder@infradead.org>, Andi Kleen <ak@linux.intel.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Tautschnig, Michael" <tautschn@amazon.co.uk>

All definitions of syscalls in x86 except for those patched here have
already been using the appropriate SYSCALL_DEFINE*.

Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jaswinder Singh <jaswinder@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/kernel/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 83a26726b689..da270b95fe4d 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
 #include <linux/context_tracking.h>
+#include <linux/syscalls.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -601,7 +602,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
  * Do a signal return; undo the signal stack.
  */
 #ifdef CONFIG_X86_32
-asmlinkage long sys_sigreturn(void)
+SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe __user *frame;
@@ -633,7 +634,7 @@ asmlinkage long sys_sigreturn(void)
 }
 #endif /* CONFIG_X86_32 */
 
-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
-- 
2.16.2
