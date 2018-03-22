Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:37686 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeCVJBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Mar 2018 05:01:43 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 42/45] x86: fix sys_sigreturn() return type to be long, not unsigned long
Date: Thu, 22 Mar 2018 10:00:56 +0100
Message-ID: <20180322090059.19361-43-linux@dominikbrodowski.net>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org, Michael Tautschnig <tautschn@amazon.co.uk>
Message-ID: <20180322090056.yuqPQL5xkQtEegVN_LS30kFa9S1ZPrhGHaTQTIC-mg0@z>

Same as with other system calls, sys_sigreturn() should return a value
of type long, not unsigned long. This also matches the behaviour for
IA32_EMULATION, see sys32_sigreturn() in arch/x86/ia32/ia32_signal.c .

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: x86@kernel.org
Cc: Michael Tautschnig <tautschn@amazon.co.uk>
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
2.16.2
