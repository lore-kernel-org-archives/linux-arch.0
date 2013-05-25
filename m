From: Mark Salter <msalter@redhat.com>
Subject: Re: possible problem with generic asm/types.h
Date: Sat, 25 May 2013 12:37:11 -0400
Message-ID: <1369499831.25297.67.camel@t520.redhat.com>
References: <1369494858.25297.58.camel@t520.redhat.com>
	 <CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22530 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757137Ab3EYQhW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 May 2013 12:37:22 -0400
In-Reply-To: <CAMuHMdVqFdbv88qDgHAGB7kmBFEwPZWVhr27KqUgiqhrUrga+A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>

On Sat, 2013-05-25 at 18:01 +0200, Geert Uytterhoeven wrote:
> On Sat, May 25, 2013 at 5:14 PM, Mark Salter <msalter@redhat.com> wrote:
> >     /*
> >      * int-ll64 is used practically everywhere now,
> 
> This comment is obsolete, it's used everywhere now.
> 
> >      * so use it as a reasonable default.
> >      */
> >     #include <asm-generic/int-ll64.h>
> >
> > Shouldn't this be:
> >
> >     #include <asm/bitsperlong.h>
> >     #if __BITS_PER_LONG == 64
> >     #include <asm-generic/int-l64.h>
> >     #else
> >     #include <asm-generic/int-ll64.h>
> >     #endif
> 
> No. Inside the kernel, all 64-bit platforms use int-ll64.h.

Except for alpha and ia64...

> 
> For backwards compatibility, alpha, ia64, mips, and powerpc (unless
> __SANE_USERSPACE_TYPES__ is defined) still use int-l64.h in userspace.
> 
> So it seems your glibc ues the old convention. Any chance you can still
> switch?

Not glibc, which provides the same stdint.h for all arches. The problem
is the namespace pollution caused by the app defining __s64 to be
glibc's int64_t. I assume that aarch64 kernel headers pull in the kernel
definition of __s64 for some reason where other kernel arches do not. So
it is just by luck that fuse builds on the other arches. I think I'll
take it up with the fuse maintainers...

--Mark
