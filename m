Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:21920 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964977AbWIDTiO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Sep 2006 15:38:14 -0400
Date: Mon, 4 Sep 2006 12:38:01 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
 _syscall*()
Message-Id: <20060904123801.905fabc6.akpm@osdl.org>
In-Reply-To: <1157398050.2473.137.camel@shinybook.infradead.org>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	<1157398050.2473.137.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, ak@suse.de, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 04 Sep 2006 12:27:29 -0700
David Woodhouse <dwmw2@infradead.org> wrote:

> On Wed, 2006-08-30 at 23:59 +0000, Linux Kernel Mailing List wrote:
> > commit 386dcafaacd212ef4a8aeed67a7db3ffbb44c7b2
> > tree 99e470b46fb81a1cde164458d03c9c9d807c1231
> > parent 266f0566761cf88906d634727b3d9fc2556f5cbd
> > author Andi Kleen <ak@suse.de> 1156959438 +0200
> > committer Linus Torvalds <torvalds@g5.osdl.org> 1156979116 -0700
> > 
> > [PATCH] i386: Remove __KERNEL__ ifdef around _syscall*()
> > 
> > After all their only point is having them in user space.
> > 
> > Signed-off-by: Andi Kleen <ak@suse.de>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> This patch is wrong. The kernel headers do _not_ exist merely to provide
> a library of stuff for userspace to abuse. In particular, they do not
> exist to provide arch maintainers with a convenient dumping ground for
> helper functionality which already exists in userspace anyway.
> 
> These macros should be inside #ifdef __KERNEL__ for three reasons:
> 
> 1. C libraries have their own syscall(); there's no _need_ for these
>    macros to be exported by the kernel.
> 
> 2. These macros work in-kernel but they are _not_ designed to work in
>    the general case in userspace. The i386 version is broken for PIC
>    code, for example.
> 
> 3. We should be consistent about what we provide in kernel headers.
>    Since we don't provide these macros on other architectures, we should
>    not do so on i386 and x86_64 -- especially as the reason for doing so
>    seems to be just that the arch maintainer doesn't want to use the
>    proper glibc function in his test hacks.
> 
> With these two patches from Andi, we have restored _syscallX() to user
> visibility on x86_64, while it's broken on i386 and absent on other
> architectures. That's a very suboptimal state of affairs.
> 
> I see three possible ways to fix this. The first, and the sanest, is
> just to put the ifdefs back and remove these macros from user view, as
> in the patch below.
> 
> The second option, if the consensus really is that we should ignore
> reason #1 above and export these unneeded macros, is that we can apply
> the patch below and then also add generic versions of _syscall*() in
> linux/unistd.h which just invoke libc's syscall(), instead of trying to
> use the in-kernel assembly versions. That would at least address #2 and
> #3 -- and in fact some distributions have been shipping with that
> in /usr/include/linux/unistd.h for a long time already.
> 
> The third, and least sensible, option would be to accept what Andi has
> done and then attempt to address #2 and #3 above by _fixing_ the macros
> so that they work in the general case -- in all types of code and on all
> architectures. Even in that case, the patch below should be applied to
> remove these macros from user view as an interim measure until they are
> actually fixed and consistent across architectures and code models.

I think we're working on removing the _syscall() things altogether.  The
main problem is execve() and I have a series from Arnd queued up to fix
execve.

I think that there are some remaining uses after execve, but I'm not sure
what they are.  Arnd, do you recall?

> What we have _now_, however, is entirely unacceptable. Please apply the
> following patch to fix it:

whimper.  that gives me a reject storm to fix up.


