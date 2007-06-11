Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2067 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbXFKSI7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 14:08:59 -0400
Date: Mon, 11 Jun 2007 19:08:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BUG] Fault handlers can deadlock
Message-ID: <20070611180852.GE16265@flint.arm.linux.org.uk>
References: <20070611160026.GA16265@flint.arm.linux.org.uk> <alpine.LFD.0.98.0706111037420.14121@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706111037420.14121@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 11, 2007 at 10:39:49AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 11 Jun 2007, Russell King wrote:
> > 
> > The deadlock involves mmap_sem having been taken by the futex code
> > and a page fault occuring in copy_from_user_inatomic().  We then
> > hit this:
> 
> No, we don't. If you hit that code, you're buggy.
> 
> Look at what x86 has just before that sequence:
> 
>         /*
>          * If we're in an interrupt, have no user context or are running in an
>          * atomic region then we must not take the fault..
>          */
>         if (in_atomic() || !mm)
>                 goto bad_area_nosemaphore;
> 
> and the whole *point* of "copy_from_user_inatomic()" is that it should 
> trigger the "in_atomic()" check, and we will never even get to the code 
> you point at:
> 
> >         /*
> >          * As per x86, we may deadlock here.  However, since the kernel only
> >          * validly references user space from well defined areas of the code,
> >          * we can bug out early if this is from code which shouldn't.
> >          */
> >         if (!down_read_trylock(&mm->mmap_sem)) {
> 
> And as far as I can see, arm has the same "in_acomit()" checks too.
> 
> Maybe the arm implementation of in_atomic() or copy_from_user_inatomic() 
> is broken some way?

Or the guy's using a very old kernel (2.6.12) and I'm pointing him at
the wrong fix (which I was.)

However, as I said to Andrew (which didn't make it to the other recipients
due to my mailer refusing to do so - yes, group reply only sent my followup
to Andrew) I think the comments could do with some improvement.

It looks like whoever did the s/in_interrupt/in_atomic/ change added
additional commentry to x86 but omitted it from ARM, leading to the
comments being misleading.

So, (as I also said to Andrew) I'm going to apply this patch to fix the
comments and thereby remove the ambiguities.

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 75d4914..368c437 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -226,8 +226,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	mm  = tsk->mm;
 
 	/*
-	 * If we're in an interrupt or have no user
-	 * context, we must not take the fault..
+	 * If we're in an atomic context (eg, interrupt, pagefault_disable,
+	 * etc) or have no user context, we must not take the fault...
+	 * We still search the exception tables.
 	 */
 	if (in_atomic() || !mm)
 		goto no_context;
@@ -235,7 +236,8 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	/*
 	 * As per x86, we may deadlock here.  However, since the kernel only
 	 * validly references user space from well defined areas of the code,
-	 * we can bug out early if this is from code which shouldn't.
+	 * we can avoid taking the semaphore entirely if the fault will lead
+	 * to an OOPS.
 	 */
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
