From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RESEND PATCH 2/4] asm-generic: io: don't perform swab during
 {in,out} string functions
Date: Fri, 19 Oct 2012 13:53:06 +0100
Message-ID: <20121019125306.GJ4582@mudshark.cambridge.arm.com>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
 <1350488704-3711-3-git-send-email-will.deacon@arm.com>
 <CAMuHMdXcQjDyen+o5aH=1zUOkNX-cfT3aXBOgCpyop=V67jk7w@mail.gmail.com>
 <1350518655.4678.120.camel@pasglop>
 <CAMuHMdWH3GXJ_dW-FCAX=LAkBuQmQtwRUtNpcqg_afm-UFK_2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:49516 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758416Ab2JSMxT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Oct 2012 08:53:19 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWH3GXJ_dW-FCAX=LAkBuQmQtwRUtNpcqg_afm-UFK_2g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mike Frysinger <vapier@gentoo.org>

On Thu, Oct 18, 2012 at 06:48:16AM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 18, 2012 at 2:04 AM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > The sort story is that endianness is not a property of the IO port but
> > of the information that transit through it. If you're just going to copy
> > it into memory, you want to preserve it's format and so do not byteswap.
> >
> > The byteswap we do on standard accessors is a "helper" because we assume
> > that underneath those IO ports are registers that are Little Endian. But
> > when using one as a window to a byte stream, we must not arbitrarily
> > swap the byte stream. We copy it as-is to memory, and then one can work
> > at interpreting the various fields that might or might not be present in
> > that stream with the appropriate accessors for memory accesses.
> 
> So assume you have the bytestream "Hello, world!\n" in memory on the
> PCI device.I.e.
> 
> 00000000  48 65 6c 6c 6f 2c 20 77  6f 72 6c 64 21 0a        |Hello, world!.|
> 
> You want to copy it to system RAM using readsl(), which does:
> 
>                u32 *buf = buffer;
>                do {
>                        u32 x = __raw_readl(addr + PCI_IOBASE);
>                        *buf++ = x;
>                 } while (--count);
> 
> On little endian, the first __raw_readl() should return "0x6c6c6548", so
> it is stored correctly by "*buf = x ".
> On big endian, the first __raw_readl() should return "0x48656c6c" instead,
> else it's stored incorrectly by "*buf = x ".

So far so good...

> But the PCI bus is little endian, so I expect __raw_readl() would return
> "0x6c6c6548", and thus needs swapping?

I think this would only happen if your busses are wired swapped, in which
case you'll have to handle this in your arch code because reading from a
device and then writing to memory will end up with the data in the wrong
order (the data stream won't be affected by passing through the CPU).

Will
