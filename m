From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Proposal: (u)intptr_t replaces (unsigned) long as opaque type
Date: Sat, 18 Sep 2010 22:06:35 -0600
Message-ID: <20100919040635.GE25139@parisc-linux.org>
References: <4C95324B.2030707@mcgary.org> <20100918235436.GD25139@parisc-linux.org> <4C9578DE.4090602@mcgary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:54680 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab0ISEGh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 19 Sep 2010 00:06:37 -0400
Content-Disposition: inline
In-Reply-To: <4C9578DE.4090602@mcgary.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg McGary <greg@mcgary.org>
Cc: linux-arch@vger.kernel.org

On Sat, Sep 18, 2010 at 07:43:42PM -0700, Greg McGary wrote:
>  On 09/18/10 16:54, Matthew Wilcox wrote:
>> Linux really only supports ILP32 and LP64 models.  Pick one, and make
>> your gcc mmtnp-unknown-linux triplet support it.
>>
>> ILP32 may be a better model for you, depending how much RAM your mmtnp
>> processor is likely to support.
>>
> Yes, I know Linux currently supports only ILP32 and LP64.  What I propose is a way to make it support something new beyond those models, and do so in a way that has no impact on vmlinux images for existing ports.

But it's only the beginnings of your problems.  There's so much userspace
code that's written assuming ILP32 / LP64.  Even inside the kernel,
people are going to constantly break your port by introducing new code
that doesn't use uintptr_t.

Then there are other things we use unsigned long for, like interrupt
status flags (spin_lock_irqsave and friends).  Should those be converted
to some new type?

> What is mmtnp?

Your processor.  I took the acronym of the description you gave.

> ILP32 will not work for me because pointers coerced to long will be truncated.  LP64 could work, but performance would suck, so that's not viable.

How bad would performance really suck?  x86-32 performance sucks on
64-bit arithmetic, but that's because it has about three registers.
With a decent size register file (16 or 32), I doubt performance will
be that bad.

If you set up your memory map correctly, truncating pointers to 32 bit
may not be a huge problem.  You can use the kmap() abstraction to run
your kernel in a 32-bit address space.

Essentially, you're asking us to take on a huge number of changes in
order to make your new processor's performance not suck.  I don't think
it likely you're going to find much sympathy here.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
