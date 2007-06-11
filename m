Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4585 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753975AbXFKQxa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 12:53:30 -0400
Date: Mon, 11 Jun 2007 17:53:22 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BUG] Fault handlers can deadlock
Message-ID: <20070611165322.GB16265@flint.arm.linux.org.uk>
References: <20070611160026.GA16265@flint.arm.linux.org.uk> <20070611094116.34e83ae6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070611094116.34e83ae6.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 11, 2007 at 09:41:16AM -0700, Andrew Morton wrote:
> On Mon, 11 Jun 2007 17:00:27 +0100 Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > Recently, a bug has been discovered on ARM whereby if futexes are
> > being used and the system is put under heavy load, a deadlock will
> > occur.
> > 
> > The deadlock involves mmap_sem having been taken by the futex code
> > and a page fault occuring in copy_from_user_inatomic().  We then
> > hit this:
> > 
> >         /*
> >          * As per x86, we may deadlock here.  However, since the kernel only
> >          * validly references user space from well defined areas of the code,
> >          * we can bug out early if this is from code which shouldn't.
> >          */
> >         if (!down_read_trylock(&mm->mmap_sem)) {
> >                 if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> >                         goto no_context;
> >                 down_read(&mm->mmap_sem);
> >         }
> 
> We shouldn't get that far, if the caller is copy_from_user_inatomic():
> 
> 	/*
> 	 * If we're in an interrupt or have no user
> 	 * context, we must not take the fault..
> 	 */
> 	if (in_atomic() || !mm)
> **taken		goto no_context;
> 
> 	/*
> 	 * As per x86, we may deadlock here.  However, since the kernel only
> 	 * validly references user space from well defined areas of the code,
> 	 * we can bug out early if this is from code which shouldn't.
> 	 */
> 	if (!down_read_trylock(&mm->mmap_sem)) {
> 		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
> 			goto no_context;
> 		down_read(&mm->mmap_sem);
> 	}
> 
> 
> I assume this is the callsite:
> 
> static inline int get_futex_value_locked(u32 *dest, u32 __user *from)
> {
> 	int ret;
> 
> 	pagefault_disable();
> 	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
> 	pagefault_enable();
> 
> 	return ret ? -EFAULT : 0;
> }
> 
> it seems to be doing the right thing there, but for some reason it isn't
> working as designed?

It's actually an older kernel, with a suggested fix (which the reporter
is refusing to apply because he thinks it'll still deadlock.)  I think
the only real answer is for the reporter to upgrade their kernel.

However, I still question whether those down_read_trylock games are
correct - they certainly do not agreement the comments directly above
which clearly indicates that the situation the code is trying to avoid
is one where the fault occurs from a location in the exception table
with mmap_sem held.

However (again) the comments in the commit (which can be viewed on
bkbits) indicates that the comment is probably wrong and the code is
correct; it's trying to early-detect conditions which will lead to an
oops.

So maybe it's a comment bug and the code is correct?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
