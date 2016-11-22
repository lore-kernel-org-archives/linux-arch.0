From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Tue, 22 Nov 2016 12:01:08 +1100
Message-ID: <20161122120108.4ffa756e@roar.ozlabs.ibm.com>
References: <14534456.e6dv16VA3R@wuerfel>
        <20161121184640.gtzvu4pfwy2p5rcb@perseus.defre.kleine-koenig.org>
        <20161121191355.GQ1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33322 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbcKVBB3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2016 20:01:29 -0500
In-Reply-To: <20161121191355.GQ1041@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <uwe@kleine-koenig.org>, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 844530@bugs.debian.org

On Mon, 21 Nov 2016 19:13:55 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Mon, Nov 21, 2016 at 07:46:44PM +0100, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Mon, Oct 24, 2016 at 05:05:26PM +0200, Arnd Bergmann wrote:  
> > > This adds an asm/asm-prototypes.h header for ARM to fix the
> > > broken symbol versioning for symbols exported from assembler
> > > files.
> > > 
> > > In addition to the header, we have to do these other small
> > > changes:
> > > 
> > > - move the exports from bitops.h to {change,clear,set,...}bit.S
> > > - move the exports from csumpartialgeneric.S into the files
> > >   including it
> > > 
> > > I couldn't find the correct prototypes for the compiler builtins,
> > > so I went with the fake 'void f(void)' prototypes that we had
> > > before.
> > > 
> > > This leaves the mmioset/mmiocpy function for now, as it's not
> > > obvious how to best handle them.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>  
> > 
> > In my test builds of 4.9-rc5 plus
> > 
> > 	4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
> > 	cc6acc11cad1 ("kbuild: be more careful about matching preprocessed asm ___EXPORT_SYMBOL")
> > 
> > (which are in -rc6) I got many warnings à la:
> > 
> > 	WARNING: "memset" [drivers/media/usb/airspy/airspy.ko] has no CRC!
> > 
> > and booting the resulting kernel failed with messages of the type:
> > 
> > 	[    3.024126] usbcore: no symbol version for __memzero
> > 	[    3.029107] usbcore: Unknown symbol __memzero (err -22)
> > 
> > so hardly any module could be loaded. modprobe -f works however, but
> > that's not what my initramfs does.
> > 
> > With this patch and https://patchwork.kernel.org/patch/9392291/ ("ARM:
> > move mmiocpy/mmioset exports to io.c") I could compile a kernel without
> > CRC warnings and it boots fine. So it would be great to get these two
> > patches into 4.9.  
> 
> Yea, many things would be nice, but I've been unable to track the
> issues here - it really didn't help _not_ being copied on the
> original set of patches which introduced this mess.

Quick overview:

- asm exports changes allow EXPORT_SYMBOL to be moved into .S files,
  but they would not get modversion CRCs generated.

- The core kbuild patches to add modversions support for asm exports
  is now merged in Linus's tree from the recent kbuild tree pull.
  asm/asm-prototypes.h must contain C style declarations of the symbol
  for this to work.

- Architectures can now add their asm/asm-prototypes.h and things
  *should* start working.

- Dependency is not a hard one. If you add asm-prototypes.h before
  merging the core patches then it should not introduce any problems.


> I've merged Nicolas' patch, so now we need to work out what to do
> with the remaining bits - which I guess are the asm-prototypes.h
> and the mmio* bits.  I'm not aware of what's happening with the
> patches that they depend on (which is why I recently asked the
> question - again, I seem to be completely out of the loop due to
> lack of Cc's).
> 
> So I'm just throwing my hands up and saying "I don't know what to
> do" at this stage.
> 

I don't think you have missed much since last it came up, it's just
taken a bit of time to get the details right and get it merged.

Not sure what your tree looks like, but if you merge this patch 1/2
plus 2a/2 or 2b/2 into upstream, then ARM should be working.

Thanks,
Nick
