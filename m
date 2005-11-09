Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 14:47:58 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109144758.GE4712@flint.arm.linux.org.uk>
References: <20051108191057.09f57114.akpm@osdl.org> <20051109133023.GD17992@linux-sh.org> <20051109134932.GB27540@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051109134932.GB27540@parisc-linux.org>
Sender: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 09, 2005 at 06:49:32AM -0700, Matthew Wilcox wrote:
> On Wed, Nov 09, 2005 at 03:30:23PM +0200, Paul Mundt wrote:
> > > +#define SA_TRIGGER_LOW		0x00000004
> > > +#define SA_TRIGGER_RISING	0x00000002
> > > +#define SA_TRIGGER_FALLING	0x00000001
> > It probably makes sense to move SA_TRIGGER here as well, as it's going to
> > be a pretty common mask. Otherwise everyone that plans to make use of
> > this will likely end up duplicating it.
> 
> Are there any other architectures that plan to make use of this?

Just to be clear - the primary reason I'm putting these in a shared
file is that we don't want to add #ifdefs to drivers (which is what
would be necessary if it was placed in asm-arm.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
