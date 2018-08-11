Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:41426 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeHKRmG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 11 Aug 2018 13:42:06 -0400
Date: Sat, 11 Aug 2018 16:07:31 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 3/6] alpha: Unify the not-implemented system call entry
 name
Message-ID: <20180811150731.GG6515@ZenIV.linux.org.uk>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
 <1531736638-15294-4-git-send-email-firoz.khan@linaro.org>
 <20180811000455.GC6515@ZenIV.linux.org.uk>
 <98937991-cefa-b7f3-11c3-12727b3159b1@twiddle.net>
 <20180811024553.GF6515@ZenIV.linux.org.uk>
 <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d223ad23-04ae-408f-2a73-d5fa641ad725@twiddle.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Henderson <rth@twiddle.net>
Cc: Firoz Khan <firoz.khan@linaro.org>, linux-alpha@vger.kernel.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com
Message-ID: <20180811150731.JDMSER7ospxdGB68kaJmhOAUwW7y6muEpu3UtQQC07U@z>

On Fri, Aug 10, 2018 at 09:10:04PM -0700, Richard Henderson wrote:
> On 08/10/2018 07:45 PM, Al Viro wrote:
> > BTW, seeing that it's your code - why was unop used in
> > alpha_ni_syscall?  I don't remember the rules re pipeline
> > stalls; is it that some earlier variants prefer unop to
> > nop in such places?  It's not that microoptimizing that
> > one makes any difference, but just out of curiosity -
> > would something like
> > 	lda     $0, -ENOSYS
> > 	stq     $sp, 0($sp)	/* sp != 0 */
> > 	ret
> > do just as well there?
> 
> Oh that.  Well, unop is a "load" and pairs with everything
> on all cpus, where nop is an integer and doesn't always
> pair.  So I got into the habit of using unop for everything.
> 
> The extra nop was so that lda + unop // stq + ret paired up
> in in two cycles as opposed to lda /stall/ stq // ret in
> three cycles on ev4+ev5.  ev6 didn't care.  FWIW.

BTW, looking through old patches around entry.S, are you OK with this
one?  Same kind of macro as that for fork/vfork/clone glue...

diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index c64806a2daf5..828d641b4410 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -791,7 +791,7 @@ ret_from_kernel_thread:
 
 /*
  * Special system calls.  Most of these are special in that they either
- * have to play switch_stack games or in some way use the pt_regs struct.
+ * have to play switch_stack games.
  */
 
 .macro	fork_like name
@@ -812,35 +812,25 @@ fork_like fork
 fork_like vfork
 fork_like clone
 
+.macro	sigreturn_like name
 	.align	4
-	.globl	sys_sigreturn
-	.ent	sys_sigreturn
-sys_sigreturn:
+	.globl	sys_\name
+	.ent	sys_\name
+sys_\name:
 	.prologue 0
 	lda	$9, ret_from_straced
 	cmpult	$26, $9, $9
 	lda	$sp, -SWITCH_STACK_SIZE($sp)
-	jsr	$26, do_sigreturn
+	jsr	$26, do_\name
 	bne	$9, 1f
 	jsr	$26, syscall_trace_leave
 1:	br	$1, undo_switch_stack
 	br	ret_from_sys_call
-.end sys_sigreturn
+.end sys_\name
+.endm
 
-	.align	4
-	.globl	sys_rt_sigreturn
-	.ent	sys_rt_sigreturn
-sys_rt_sigreturn:
-	.prologue 0
-	lda	$9, ret_from_straced
-	cmpult	$26, $9, $9
-	lda	$sp, -SWITCH_STACK_SIZE($sp)
-	jsr	$26, do_rt_sigreturn
-	bne	$9, 1f
-	jsr	$26, syscall_trace_leave
-1:	br	$1, undo_switch_stack
-	br	ret_from_sys_call
-.end sys_rt_sigreturn
+sigreturn_like sigreturn
+sigreturn_like rt_sigreturn
 
 	.align	4
 	.globl	alpha_ni_syscall
