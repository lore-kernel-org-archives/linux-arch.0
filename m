Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Nov 2005 13:24:49 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: irq-type-flags.patch
Message-ID: <20051109132449.GC4712@flint.arm.linux.org.uk>
References: <20051108191057.09f57114.akpm@osdl.org> <26691.1131542400@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26691.1131542400@warthog.cambridge.redhat.com>
Sender: Russell King <rmk@arm.linux.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 09, 2005 at 01:20:00PM +0000, David Howells wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > +			desc->chip->set_type(irq, type);
> 
> How's the error handled if the PIC can't handle the requested type?
> 
> It seems like it ought to be wrong that the driver is setting this. It ought
> to be a property of the arch or the bus.

No it should not.  Neither the arch not the bus dictates what the
device manufacturer decides to do with their interrupt output.

It most definitely is a property of the device/driver and not a
higher level.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
