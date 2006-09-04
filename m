Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751356AbWIDT5Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Sep 2006 15:57:24 -0400
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20060904123801.905fabc6.akpm@osdl.org>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	 <1157398050.2473.137.camel@shinybook.infradead.org>
	 <20060904123801.905fabc6.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 12:56:57 -0700
Message-Id: <1157399818.2473.154.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, ak@suse.de, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 12:38 -0700, Andrew Morton wrote:
> I think we're working on removing the _syscall() things altogether.  The
> main problem is execve() and I have a series from Arnd queued up to fix
> execve.

Yes, that's an eminently sensible plan.

> I think that there are some remaining uses after execve, but I'm not sure
> what they are.  Arnd, do you recall?

There was some SH64 debugging code which can be removed altogether, and
some code in UML which can be fixed to use syscall(). Arnd's patch
sequence did both.

And then, of course, there's some of Andi's test code in userspace -- in
which for some reason he doesn't _want_ to use glibc's syscall()
function. That seems to be why he restored the broken _syscallX()
functions to userspace visibility after we'd removed them once.

Not entirely sure what we can do about that, except perhaps adding what
Fedora had in linux/unistd.h for a long time -- versions of _syscallX()
in #ifndef __KERNEL__ which do use glibc's syscall() function properly.
That was my 'option 2', but it's not something that should really live
in kernel headers, IMHO.

> > What we have _now_, however, is entirely unacceptable. Please apply the
> > following patch to fix it:
> 
> whimper.  that gives me a reject storm to fix up.

Sorry :)

You could drop the addition of comments after the #endifs, if that helps
-- the only important part is moving the #ifdef __KERNEL__ up to the end
of the syscall table. I suspect it doesn't help though -- the hunk which
conflicts is almost certainly going to be the addition of the #ifdef at
the end of the syscall table.

-- 
dwmw2

