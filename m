Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 15:27:28 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109152727.GG4712@flint.arm.linux.org.uk>
References: <20051109132449.GC4712@flint.arm.linux.org.uk> <20051108191057.09f57114.akpm@osdl.org> <26691.1131542400@warthog.cambridge.redhat.com> <7224.1131549227@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7224.1131549227@warthog.cambridge.redhat.com>
Sender: Russell King <rmk@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 09, 2005 at 03:13:47PM +0000, David Howells wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > Neither the arch not the bus dictates what the
> > device manufacturer decides to do with their interrupt output.
> 
> On the other hand, the device manufacturer does not decree what the arch and
> supporting chipset will *accept*.

David, you have completely the wrong idea about this.  The driver does
not decree anything.  The driver is telling the IRQ subsystem what type
of interrupt the chip produces.

If an _architecture_ wants to indirect that through something, all well
and good - it can, but that's up to the architectures request_irq()
internals.

> There's no guarantee that all trigger types
> will be supported. For instance on my ASB2305 board, I've got an on-chip PIC
> that will accept any of the four trigger types, but the PCI bus interrupt line
> attached to one of the external interrupt pins will *only* accept low-level
> triggered. In such a case, the bus *must* override anything set by one of the
> devices.

We have this scenario on ARM today - for years - and it isn't a problem
there.  So why is it such a massive problem here?

I think the root of this issue is that you're thinking that the driver
uses this to dictate to the interrupt controller what it wants the
controller to program itself for.  It's more a case that the driver is
saying "my device produces this kind of interrupt, please configure
the input appropriately."

Maybe the real issue here is that we should have dev_request_irq which
takes a struct device?  That's another, separate, orthogonal interface
extension which those who require it can work on.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
