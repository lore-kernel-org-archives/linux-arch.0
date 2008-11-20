From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 05/35] reintroduce accept4
Date: Thu, 20 Nov 2008 14:14:02 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
References: <200811192336.mAJNaE3R030021@imap1.linux-foundation.org> <Pine.LNX.4.64.0811202259360.12975@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45893 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756139AbYKTWPC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Nov 2008 17:15:02 -0500
In-Reply-To: <Pine.LNX.4.64.0811202259360.12975@anakin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: akpm@linux-foundation.org, drepper@redhat.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mtk.manpages@gmail.com



On Thu, 20 Nov 2008, Geert Uytterhoeven wrote:

> On Wed, 19 Nov 2008, akpm@linux-foundation.org wrote:
> > From: Ulrich Drepper <drepper@redhat.com>
> > 
> > Introduce a new accept4() system call.  The addition of this system call
> 
> > /* test_accept4.c
> 
> > #ifdef __x86_64__
> > #define SYS_accept4 288
> > #elif __i386__
>         ^^^^^^^^
> 	defined(__i386__)
> 
> > #define USE_SOCKETCALL 1
> > #define SYS_ACCEPT4 18
> > #else
> > #error "Sorry -- don't know the syscall # on this architecture"
> > #endif
> 
> Anyway, it's just a test program. Succeeded on m68k using socketcall.

It _should_ work even without the 'defined()'. Didn't it?

Unknown symbols should expand to '0' in preprocessor value evaluation. Of 
course, the compiler may warn about the practice, but it shouldn't be 
technically wrong.

		Linus
