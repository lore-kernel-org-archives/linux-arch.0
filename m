Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from monty.telenet-ops.be ([195.130.132.56]:35971 "EHLO
	monty.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbYKUHU7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Nov 2008 02:20:59 -0500
Date: Fri, 21 Nov 2008 08:20:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [patch 05/35] reintroduce accept4
In-Reply-To: <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0811210819070.12975@anakin>
References: <200811192336.mAJNaE3R030021@imap1.linux-foundation.org>
 <Pine.LNX.4.64.0811202259360.12975@anakin>
 <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, drepper@redhat.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mtk.manpages@gmail.com
Message-ID: <20081121072055.NLOGRRDT3kEDq9a8cN0jt2PrKOASq3ljmGXPXbFhuRQ@z>

On Thu, 20 Nov 2008, Linus Torvalds wrote:
> On Thu, 20 Nov 2008, Geert Uytterhoeven wrote:
> > On Wed, 19 Nov 2008, akpm@linux-foundation.org wrote:
> > > From: Ulrich Drepper <drepper@redhat.com>
> > > 
> > > Introduce a new accept4() system call.  The addition of this system call
> > 
> > > /* test_accept4.c
> > 
> > > #ifdef __x86_64__
> > > #define SYS_accept4 288
> > > #elif __i386__
> >         ^^^^^^^^
> > 	defined(__i386__)
> > 
> > > #define USE_SOCKETCALL 1
> > > #define SYS_ACCEPT4 18
> > > #else
> > > #error "Sorry -- don't know the syscall # on this architecture"
> > > #endif
> > 
> > Anyway, it's just a test program. Succeeded on m68k using socketcall.
> 
> It _should_ work even without the 'defined()'. Didn't it?

Yes it worked.

> Unknown symbols should expand to '0' in preprocessor value evaluation. Of 
> course, the compiler may warn about the practice, but it shouldn't be 
> technically wrong.

gcc 4.4 complains:
http://www.cyrius.com/journal/gcc/gcc-4.4-preprocessor-errors

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
