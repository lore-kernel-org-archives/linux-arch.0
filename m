Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:55542 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754113AbYBEJzH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Feb 2008 04:55:07 -0500
Date: Tue, 5 Feb 2008 10:54:54 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] Fix timerfd breakage on avr32
Message-ID: <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
In-Reply-To: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, davidel@xmailserver.org
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de

sys_timerfd() has been removed, but avr32 still references it from its
syscall table.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
On Mon, 04 Feb 2008 22:27:28 -0800
akpm@linux-foundation.org wrote:

> From: Davide Libenzi <davidel@xmailserver.org>
> 
> Wires up the new timerfd API to the x86 family.

Just one thing...

> diff -puN arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family arch/x86/kernel/syscall_table_32.S
> --- a/arch/x86/kernel/syscall_table_32.S~timerfd-v3-wire-the-new-timerfd-api-to-the-x86-family
> +++ a/arch/x86/kernel/syscall_table_32.S
> @@ -321,6 +321,8 @@ ENTRY(sys_call_table)
>  	.long sys_epoll_pwait
>  	.long sys_utimensat		/* 320 */
>  	.long sys_signalfd
> -	.long sys_timerfd

The next time you go and remove a system call, could you _please_ post
a HUGE warning to linux-arch? Or just do a quick grep and fix it up.

Judging by the number of -fix patches in -mm,
timerfd-v3-new-timerfd-api.patch broke almost every single architecture
in the tree. And not only is this potential breakage never mentioned in
the patch description, the patch that actually removes the
sys_timerfd() implementation was never Cc'ed linux-arch.

While I agree that new syscalls don't necessarily have to come wired up
and ready to use on all architectures, you need to take a lot more care
when removing syscalls that have already been wired up.

The patch below fixes avr32. Please apply.

 arch/avr32/kernel/syscall_table.S |    2 +-
 include/asm-avr32/unistd.h        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/avr32/kernel/syscall_table.S~fix-timerfd-breakage-on-avr32-was-re-fix-variable-use-in-avr32-pte_alloc_one arch/avr32/kernel/syscall_table.S
--- a/arch/avr32/kernel/syscall_table.S~fix-timerfd-breakage-on-avr32-was-re-fix-variable-use-in-avr32-pte_alloc_one
+++ a/arch/avr32/kernel/syscall_table.S
@@ -293,6 +293,6 @@ sys_call_table:
 	.long	sys_shmctl
 	.long	sys_utimensat
 	.long	sys_signalfd
-	.long	sys_timerfd		/* 280 */
+	.long	sys_ni_syscall		/* 280, was sys_timerfd */
 	.long	sys_eventfd
 	.long	sys_ni_syscall		/* r8 is saturated at nr_syscalls */
diff -puN include/asm-avr32/unistd.h~fix-timerfd-breakage-on-avr32-was-re-fix-variable-use-in-avr32-pte_alloc_one include/asm-avr32/unistd.h
--- a/include/asm-avr32/unistd.h~fix-timerfd-breakage-on-avr32-was-re-fix-variable-use-in-avr32-pte_alloc_one
+++ a/include/asm-avr32/unistd.h
@@ -297,7 +297,7 @@
 
 #define __NR_utimensat		278
 #define __NR_signalfd		279
-#define __NR_timerfd		280
+/* 280 was __NR_timerfd */
 #define __NR_eventfd		281
 
 #ifdef __KERNEL__
