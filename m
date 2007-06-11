Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48081 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751639AbXFKRby (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jun 2007 13:31:54 -0400
Date: Mon, 11 Jun 2007 10:31:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] Fault handlers can deadlock
Message-Id: <20070611103142.a9e55928.akpm@linux-foundation.org>
In-Reply-To: <20070611165322.GB16265@flint.arm.linux.org.uk>
References: <20070611160026.GA16265@flint.arm.linux.org.uk>
	<20070611094116.34e83ae6.akpm@linux-foundation.org>
	<20070611165322.GB16265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 11 Jun 2007 17:53:22 +0100
Russell King <rmk@arm.linux.org.uk> wrote:

> On Mon, Jun 11, 2007 at 09:41:16AM -0700, Andrew Morton wrote:
> > On Mon, 11 Jun 2007 17:00:27 +0100 Russell King <rmk@arm.linux.org.uk> wrote:
> > 
> > > Recently, a bug has been discovered on ARM whereby if futexes are
> > > being used and the system is put under heavy load, a deadlock will
> > > occur.
> > > 
> > > The deadlock involves mmap_sem having been taken by the futex code
> > > and a page fault occuring in copy_from_user_inatomic().  We then
> > > hit this:
> > > 
> > >         /*
> > >          * As per x86, we may deadlock here.  However, since the kernel only
> > >          * validly references user space from well defined areas of the code,
> > >          * we can bug out early if this is from code which shouldn't.
> > >          */
> > >         if (!down_read_trylock(&mm->mmap_sem)) {
> > >                 if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> > >                         goto no_context;
> > >                 down_read(&mm->mmap_sem);
> > >         }
> > 
> > We shouldn't get that far, if the caller is copy_from_user_inatomic():
> > 
> > 	/*
> > 	 * If we're in an interrupt or have no user
> > 	 * context, we must not take the fault..
> > 	 */
> > 	if (in_atomic() || !mm)
> > **taken		goto no_context;
> > 
> > 	/*
> > 	 * As per x86, we may deadlock here.  However, since the kernel only
> > 	 * validly references user space from well defined areas of the code,
> > 	 * we can bug out early if this is from code which shouldn't.
> > 	 */
> > 	if (!down_read_trylock(&mm->mmap_sem)) {
> > 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> > 			goto no_context;
> > 		down_read(&mm->mmap_sem);
> > 	}
> > 
> > 
> > I assume this is the callsite:
> > 
> > static inline int get_futex_value_locked(u32 *dest, u32 __user *from)
> > {
> > 	int ret;
> > 
> > 	pagefault_disable();
> > 	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
> > 	pagefault_enable();
> > 
> > 	return ret ? -EFAULT : 0;
> > }
> > 
> > it seems to be doing the right thing there, but for some reason it isn't
> > working as designed?
> 
> It's actually an older kernel, with a suggested fix (which the reporter
> is refusing to apply because he thinks it'll still deadlock.)  I think
> the only real answer is for the reporter to upgrade their kernel.
> 
> However, I still question whether those down_read_trylock games are
> correct - they certainly do not agreement the comments directly above
> which clearly indicates that the situation the code is trying to avoid
> is one where the fault occurs from a location in the exception table
> with mmap_sem held.
> 
> However (again) the comments in the commit (which can be viewed on
> bkbits) indicates that the comment is probably wrong and the code is
> correct; it's trying to early-detect conditions which will lead to an
> oops.
> 
> So maybe it's a comment bug and the code is correct?

The code is there to improve debuggability and for no other reason.  It is
to fix the situation where the kernel references an invalida address while
holding down_write(mmap_sem).  We used to take the fault and then deadlock
on do_page_fault()'s down_read().  Now, we do the trylock and if that fails
we chech that a) it was running kernel code and b) the kernel didn't expect
a fault to occur at that EIP.  If both of those are true, go off and report
the oops rather than deadlocking.

And I don't think I spot anything in either the ARM or i386 comments which
contradicts that? 

