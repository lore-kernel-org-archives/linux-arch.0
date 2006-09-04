Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:25272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751426AbWIDUv1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Sep 2006 16:51:27 -0400
Subject: Re: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200609042156.40143.arnd@arndb.de>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
	 <1157398050.2473.137.camel@shinybook.infradead.org>
	 <20060904123801.905fabc6.akpm@osdl.org>  <200609042156.40143.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 13:50:59 -0700
Message-Id: <1157403059.2473.189.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, ak@suse.de, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2006-09-04 at 21:56 +0200, Arnd Bergmann wrote:
> Andi's point was that it is an essential part of the kernel ABI and
> we should not break existing source using these macros, especially
> since the alternative syscall() function provided by glibc has been
> frequently broken in the past on x86.

That argument would make more sense if the _syscallX() macros weren't
even more broken. 2.6.17 was the first recent release in which they even
_compiled_ in PIC code on i386, because they clobbered %ebx.

A significant amount of code accessing syscalls directly is going to be
in some kind of library -- which means PIC code -- which means that
_syscallX() as provided by the kernel was just broken. This was 'fixed'
in March, which means there was a window of about a month when the
macros were working on i386, before I removed them from view.

In Fedora, we used to work around this by just providing a hack in
<linux/unistd.h> which invokes glibc's syscall() instead.

Nowadays, we don't ship _syscallX() at all in Fedora. When we dropped
them, I had to fix one or two userspace programs -- but not many.

One of the programs I had to fix was qemu. When I did so, I found it had
its own implementation of _syscallX() for PowerPC, for some reason. I
didn't investigate precisely what qemu's problem was with the kernel's
version -- the correct answer for userspace is to use libc's syscall(),
and that's what I did.

But arguing that we should keep _syscallX() because of historical bugs
with syscal() is fairly bizarre -- if anything, it's the other way
round. The _syscallX() macros have always been buggy in userspace, to
the point where we transparently redirected users of them to syscall()
instead.

> HPA made the point that syscall() from glibc is by design inefficient
> on some architectures, so there may be reasons to use _syscallX()
> instead.

I think he was talking about the placement of 64-bit arguments. Some
32-bit architectures require that 64-bit function arguments be put in an
_aligned_ pair of registers -- i.e. if you have 

	int foo(int a, uint64_t b);

... you get 'a' in the first argument register, but then the second
argument register is unused, and 'b' goes into the third and fourth,
because it needs to be in an even/odd register pair.

That isn't a coherent argument for using the kernel's _syscallX() macros
either, though -- because those just cast the 64-bit argument to a
single 'long', and are thus broken for 64-bit arguments _even_ on
machines where we don't have alignment constraints like the above.

Again, _syscallX() is more broken than syscall() is.

-- 
dwmw2

