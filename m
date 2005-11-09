Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 15:28:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109152810.GH4712@flint.arm.linux.org.uk>
References: <20051108191057.09f57114.akpm@osdl.org> <20051109133023.GD17992@linux-sh.org> <20051109134932.GB27540@parisc-linux.org> <20051109144758.GE4712@flint.arm.linux.org.uk> <20051109152659.GD27540@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109152659.GD27540@parisc-linux.org>
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 09, 2005 at 08:26:59AM -0700, Matthew Wilcox wrote:
> On Wed, Nov 09, 2005 at 02:47:58PM +0000, Russell King wrote:
> > On Wed, Nov 09, 2005 at 06:49:32AM -0700, Matthew Wilcox wrote:
> > > On Wed, Nov 09, 2005 at 03:30:23PM +0200, Paul Mundt wrote:
> > > > > +#define SA_TRIGGER_LOW		0x00000004
> > > > > +#define SA_TRIGGER_RISING	0x00000002
> > > > > +#define SA_TRIGGER_FALLING	0x00000001
> > > > It probably makes sense to move SA_TRIGGER here as well, as it's going to
> > > > be a pretty common mask. Otherwise everyone that plans to make use of
> > > > this will likely end up duplicating it.
> > > 
> > > Are there any other architectures that plan to make use of this?
> > 
> > Just to be clear - the primary reason I'm putting these in a shared
> > file is that we don't want to add #ifdefs to drivers (which is what
> > would be necessary if it was placed in asm-arm.)
> 
> Certainly.  The question is whether it makes sense to put the SA_TRIGGER
> define (being the | of all these) in arch files or in the common files.
> And it sounds like since SH also needs to use this, that should also go
> in adjacent to the SA_TRIGGER_* defines.

I'm fine with moving it there.  Shall I do a new patch?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
