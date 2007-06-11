Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40774 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752883AbXFKQlc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jun 2007 12:41:32 -0400
Date: Mon, 11 Jun 2007 09:41:16 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUG] Fault handlers can deadlock
Message-Id: <20070611094116.34e83ae6.akpm@linux-foundation.org>
In-Reply-To: <20070611160026.GA16265@flint.arm.linux.org.uk>
References: <20070611160026.GA16265@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 11 Jun 2007 17:00:27 +0100 Russell King <rmk@arm.linux.org.uk> wrote:

> Recently, a bug has been discovered on ARM whereby if futexes are
> being used and the system is put under heavy load, a deadlock will
> occur.
> 
> The deadlock involves mmap_sem having been taken by the futex code
> and a page fault occuring in copy_from_user_inatomic().  We then
> hit this:
> 
>         /*
>          * As per x86, we may deadlock here.  However, since the kernel only
>          * validly references user space from well defined areas of the code,
>          * we can bug out early if this is from code which shouldn't.
>          */
>         if (!down_read_trylock(&mm->mmap_sem)) {
>                 if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
>                         goto no_context;
>                 down_read(&mm->mmap_sem);
>         }

We shouldn't get that far, if the caller is copy_from_user_inatomic():

	/*
	 * If we're in an interrupt or have no user
	 * context, we must not take the fault..
	 */
	if (in_atomic() || !mm)
**taken		goto no_context;

	/*
	 * As per x86, we may deadlock here.  However, since the kernel only
	 * validly references user space from well defined areas of the code,
	 * we can bug out early if this is from code which shouldn't.
	 */
	if (!down_read_trylock(&mm->mmap_sem)) {
		if (!user_mode(regs) && !search_exception_tables(regs->ARM_pc))
			goto no_context;
		down_read(&mm->mmap_sem);
	}


I assume this is the callsite:

static inline int get_futex_value_locked(u32 *dest, u32 __user *from)
{
	int ret;

	pagefault_disable();
	ret = __copy_from_user_inatomic(dest, from, sizeof(u32));
	pagefault_enable();

	return ret ? -EFAULT : 0;
}

it seems to be doing the right thing there, but for some reason it isn't
working as designed?
