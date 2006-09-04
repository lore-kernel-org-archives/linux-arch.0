Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:55776 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751482AbWIDVQx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Sep 2006 17:16:53 -0400
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200609042230.13455.ak@suse.de>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	 <1157398050.2473.137.camel@shinybook.infradead.org>
	 <200609042230.13455.ak@suse.de>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 14:16:48 -0700
Message-Id: <1157404608.2473.205.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 22:30 +0200, Andi Kleen wrote:
> > 1. C libraries have their own syscall(); there's no _need_ for these
> >    macros to be exported by the kernel.
> 
> I like having them there. I find it it useful for my test programs.

Nevertheless, you could happily use syscall() as provided by glibc -- or
you could keep your own copy of _syscallX around. You don't need to
pollute the kernel with this stuff just so that you can use it in your
own test programs.

> It's also useful for numactl for once.

What makes you say that? Numactl seems used glibc's syscall(), not the
kernel's _syscallX(). Although it does provide its own syscall6() on
both i386 and x86_64 -- citing bugs in both kernel and glibc versions,
although not actually giving bug numbers. But basically, it's using
glibc's syscall().

> > 3. We should be consistent about what we provide in kernel headers.
> >    Since we don't provide these macros on other architectures, we should
> >    not do so on i386 and x86_64 -- especially as the reason for doing so
> >    seems to be just that the arch maintainer doesn't want to use the
> >    proper glibc function in his test hacks.
> 
> We've always provided them and continuing to do so is consistent.

They've always been broken, and we've _never_ been consistent about what
we provide to userspace in kernel headers in the past -- we're only
recently starting to get our act together in that respect, and your
patches _reverted_ some of the cleanup which was part of that process.

Our best option, at this point, is to remove the kernel versions again
and let userspace use syscall(). Like numactl() already does.

-- 
dwmw2

