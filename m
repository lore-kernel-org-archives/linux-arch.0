Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:38739 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbXFYMf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 08:35:26 -0400
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <2fc3aacccf036072f1b959e7b9ec3629@kernel.crashing.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
	 <20070625021145.b84ea186.akpm@linux-foundation.org>
	 <20070625103535.GF22063@parisc-linux.org>
	 <20070625110907.GA23438@flint.arm.linux.org.uk>
	 <1182771454.12109.71.camel@pmac.infradead.org>
	 <20070625114742.GG22063@parisc-linux.org>
	 <2fc3aacccf036072f1b959e7b9ec3629@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 13:34:33 +0100
Message-Id: <1182774873.12109.83.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Russell King <rmk@arm.linux.org.uk>, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, drepper@redhat.com, paulus@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-06-25 at 14:04 +0200, Segher Boessenkool wrote:
> >> - Some architectures must align 64-bit integers into an aligned
> >>   pair of registers. A slot may be wasted for padding.
> >> - S390 may not have a 64-bit integer in slots 5/6.
> >
> > Uhm, doesn't sys_sync_file_range2 break that?
> >
> > +asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int 
> > flags,
> > +                                  unsigned offset_hi, unsigned 
> > offset_lo,
> > +                                  unsigned nbytes_hi, unsigned 
> > nbytes_lo)
> 
> I don't see any 64-bit integers here.

Of course not. This is the routine which is called from 32-bit code.
The prototype in the 32-bit code is (int, unsigned, loff_t, loff_t).

> > Also, you might want to put something in the syscall file about signed
> > vs unsigned arguments and how they behave with 32-on-64 systems.
> 
> "Both work / unsigned is better / use unsigned whenever
> possible" -- but that's true for all C coding.  Wouldn't
> hurt to repeat it though :-)

Don't we need (int)(-1) to be represented as 0xFFFFFFFFFFFFFFFF in a
register in 64-bit code, while we only get 0xFFFFFFFF passed in from
userspace? Not that this explains why we're doing it even for
filedescriptors.

-- 
dwmw2

