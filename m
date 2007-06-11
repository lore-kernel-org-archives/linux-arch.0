Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48586 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752620AbXFKRkH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jun 2007 13:40:07 -0400
Date: Mon, 11 Jun 2007 10:39:49 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] Fault handlers can deadlock
In-Reply-To: <20070611160026.GA16265@flint.arm.linux.org.uk>
Message-ID: <alpine.LFD.0.98.0706111037420.14121@woody.linux-foundation.org>
References: <20070611160026.GA16265@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>



On Mon, 11 Jun 2007, Russell King wrote:
> 
> The deadlock involves mmap_sem having been taken by the futex code
> and a page fault occuring in copy_from_user_inatomic().  We then
> hit this:

No, we don't. If you hit that code, you're buggy.

Look at what x86 has just before that sequence:

        /*
         * If we're in an interrupt, have no user context or are running in an
         * atomic region then we must not take the fault..
         */
        if (in_atomic() || !mm)
                goto bad_area_nosemaphore;

and the whole *point* of "copy_from_user_inatomic()" is that it should 
trigger the "in_atomic()" check, and we will never even get to the code 
you point at:

>         /*
>          * As per x86, we may deadlock here.  However, since the kernel only
>          * validly references user space from well defined areas of the code,
>          * we can bug out early if this is from code which shouldn't.
>          */
>         if (!down_read_trylock(&mm->mmap_sem)) {

And as far as I can see, arm has the same "in_acomit()" checks too.

Maybe the arm implementation of in_atomic() or copy_from_user_inatomic() 
is broken some way?

		Linus
