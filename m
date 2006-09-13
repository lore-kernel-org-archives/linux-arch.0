Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:64778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750739AbWIMQiX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 12:38:23 -0400
Date: Wed, 13 Sep 2006 17:38:06 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
Message-ID: <20060913163806.GA15563@flint.arm.linux.org.uk>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com> <20060913161734.GE3564@stusta.de> <20060913163136.GA2585@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913163136.GA2585@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Adrian Bunk <bunk@stusta.de>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Sep 13, 2006 at 10:31:36AM -0600, Matthew Wilcox wrote:
> On Wed, Sep 13, 2006 at 06:17:34PM +0200, Adrian Bunk wrote:
> > On Wed, Sep 13, 2006 at 02:03:00PM +0100, David Howells wrote:
> > > From: David Howells <dhowells@redhat.com>
> > > 
> > > This facility provides three entry points:
> > > 
> > > 	log2()		Log base 2 of u32
> > >...
> > 
> > Considering that several arch maintainers have vetoed my patch to revert 
> > the -ffreestanding removal Andi sneaked in with his usual trick to hide 
> > generic patches as "x86_64 patch", such a usage of a libc function name 
> > with a signature different from the one defined in ISO/IEC 9899:1999 is 
> > a namespace violation that mustn't happen.
> 
> log2 is only defined if math.h gets included.  If we're including math.h
> at any point in the kernel itself (excluding the bootloader and similar),
> we're already screwed six ways from sunday.

Adrian's point is that gcc without -ffreestanding may decide to implement
log2() itself by issuing the appropriate floating point instructions
rather than using a function call into a library to do this operation.

Therefore, re-using "log2()" is about as bad as re-using the "strcmp()"
name to implement a function which copies strings.

And, sure enough, try throwing this at a compiler:

int log2(int foo)
{
	return foo;
}

you get:

t.c:2: warning: conflicting types for built-in function 'log2'

but not if you use -ffreestanding.

Don't re-use C standard library identifiers (or use -ffreestanding.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
