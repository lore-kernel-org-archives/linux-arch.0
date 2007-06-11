Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54746 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752497AbXFKRvQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jun 2007 13:51:16 -0400
Date: Mon, 11 Jun 2007 10:51:03 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] Fault handlers can deadlock
In-Reply-To: <20070611165322.GB16265@flint.arm.linux.org.uk>
Message-ID: <alpine.LFD.0.98.0706111041570.14121@woody.linux-foundation.org>
References: <20070611160026.GA16265@flint.arm.linux.org.uk>
 <20070611094116.34e83ae6.akpm@linux-foundation.org>
 <20070611165322.GB16265@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Mon, 11 Jun 2007, Russell King wrote:
> 
> However, I still question whether those down_read_trylock games are
> correct

That is certainly a valid question. It may well be that we should *always* 
do the "search_exception_tables()" for kernel accesses. As it is, we 
aren't doing all the validity checks that we *could* do.

However, the deadlock is real, and concerns kernel *bugs*:

 - if the kernel takes a (wild) page fault while holding the mmap_sem 
   semaphore, we at one point just deadlocked instead of printign a nice 
   oops message. Some people (including me) spent way too much time 
   debugging silent and very-hard-to-debug lockups that should have just 
   caused a nice oops and made the bug obvious.

However, I agree that the check itself conceptually should be done 
regardless of whether the mmap_sem is taken or not.

One solution migt be to just move the whole

	if (!user_mode(regs) && !search_exception_tables(pc))
		goto no_context;

to _outside_ the mmap_sem check, and change the code to basically be

        /*
         * If we're in an interrupt or have no user
         * context, we must not take the fault..
         */
        if (in_atomic() || !mm)
                goto no_context;

	/*
	 * If we're in kernel mode, and don't have the access
	 * listed in the exception tables, we must not take
	 * the fault...
	 */
	if (!user_mode(regs) && !search_exception_tables(pc))
		goto no_context;

	/* Do the fault */
	down_read(&mm->mmap_sem);
	fault = __do_page_fault(mm, addr, flags, tsk);
	up_read(&mm->mmap_sem);

which looks cleaner, I agree.

However, one issue that I don't know was ever part of the reason is that 
the exception table search may be expensive, and maybe skipping it when 
getting the mmap_sem is easy is the right thing for a _performance_ 
reason. I doubt it's a real issue (we should generally not be taking 
a lot of faults from kernel mode!), but it's a thing to keep in mind.

Comments?

		Linus
