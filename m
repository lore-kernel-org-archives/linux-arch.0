From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 100/109] x86: fix sys_sigreturn() return type to be long, not unsigned long
Date: Thu, 29 Mar 2018 13:24:17 +0200
Message-ID: <20180329112426.23043-101-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org, Michael Tautschnig <tautschn@amazon.co.uk>
List-Id: linux-arch.vger.kernel.org

Same as with other system calls, sys_sigreturn() should return a value
of type long, not unsigned long. This also matches the behaviour for
IA32_EMULATION, see sys32_sigreturn() in arch/x86/ia32/ia32_signal.c .

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Cc: Michael Tautschnig <tautschn@amazon.co.uk>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/include/asm/syscalls.h | 2 +-
 arch/x86/kernel/signal.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index 1c0bebbd039e..ae6e05fdc24b 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -35,7 +35,7 @@ asmlinkage long sys_get_thread_area(struct user_desc __user *);
 #ifdef CONFIG_X86_32
 
 /* kernel/signal.c */
-asmlinkage unsigned long sys_sigreturn(void);
+asmlinkage long sys_sigreturn(void);
 
 /* kernel/vm86_32.c */
 struct vm86_struct;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 4cdc0b27ec82..83a26726b689 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -601,7 +601,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
  * Do a signal return; undo the signal stack.
  */
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long sys_sigreturn(void)
+asmlinkage long sys_sigreturn(void)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe __user *frame;
-- 
2.16.3
