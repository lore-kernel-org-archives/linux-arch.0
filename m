Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from waste.org ([66.93.16.53]:56106 "EHLO waste.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271AbYKTWiM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 20 Nov 2008 17:38:12 -0500
Subject: Re: [patch 05/35] reintroduce accept4
From: Matt Mackall <mpm@selenic.com>
In-Reply-To: <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
References: <200811192336.mAJNaE3R030021@imap1.linux-foundation.org>
	 <Pine.LNX.4.64.0811202259360.12975@anakin>
	 <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
Content-Type: text/plain
Date: Thu, 20 Nov 2008 16:37:06 -0600
Message-ID: <1227220626.3293.137.camel@calx>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, akpm@linux-foundation.org, drepper@redhat.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mtk.manpages@gmail.com
Message-ID: <20081120223706.Tj6ZKrG4VRR1-MhtZcskWBRiYXaCG3x5IWURLq92gT0@z>

On Thu, 2008-11-20 at 14:14 -0800, Linus Torvalds wrote:
> 
> On Thu, 20 Nov 2008, Geert Uytterhoeven wrote:
> 
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

Lots of symbols are defined with no value, which will result in an empty
#if expression and a cpp error.

-- 
Mathematics is the supreme nostalgia of our time.

