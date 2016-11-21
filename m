From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Mon, 21 Nov 2016 19:13:55 +0000
Message-ID: <20161121191355.GQ1041@n2100.armlinux.org.uk>
References: <14534456.e6dv16VA3R@wuerfel>
 <20161121184640.gtzvu4pfwy2p5rcb@perseus.defre.kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161121184640.gtzvu4pfwy2p5rcb@perseus.defre.kleine-koenig.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 844530@bugs.debian.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 21, 2016 at 07:46:44PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Oct 24, 2016 at 05:05:26PM +0200, Arnd Bergmann wrote:
> > This adds an asm/asm-prototypes.h header for ARM to fix the
> > broken symbol versioning for symbols exported from assembler
> > files.
> > 
> > In addition to the header, we have to do these other small
> > changes:
> > 
> > - move the exports from bitops.h to {change,clear,set,...}bit.S
> > - move the exports from csumpartialgeneric.S into the files
> >   including it
> > 
> > I couldn't find the correct prototypes for the compiler builtins,
> > so I went with the fake 'void f(void)' prototypes that we had
> > before.
> > 
> > This leaves the mmioset/mmiocpy function for now, as it's not
> > obvious how to best handle them.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> In my test builds of 4.9-rc5 plus
> 
> 	4efca4ed05cb ("kbuild: modversions for EXPORT_SYMBOL() for asm")
> 	cc6acc11cad1 ("kbuild: be more careful about matching preprocessed asm ___EXPORT_SYMBOL")
> 
> (which are in -rc6) I got many warnings à la:
> 
> 	WARNING: "memset" [drivers/media/usb/airspy/airspy.ko] has no CRC!
> 
> and booting the resulting kernel failed with messages of the type:
> 
> 	[    3.024126] usbcore: no symbol version for __memzero
> 	[    3.029107] usbcore: Unknown symbol __memzero (err -22)
> 
> so hardly any module could be loaded. modprobe -f works however, but
> that's not what my initramfs does.
> 
> With this patch and https://patchwork.kernel.org/patch/9392291/ ("ARM:
> move mmiocpy/mmioset exports to io.c") I could compile a kernel without
> CRC warnings and it boots fine. So it would be great to get these two
> patches into 4.9.

Yea, many things would be nice, but I've been unable to track the
issues here - it really didn't help _not_ being copied on the
original set of patches which introduced this mess.

I've merged Nicolas' patch, so now we need to work out what to do
with the remaining bits - which I guess are the asm-prototypes.h
and the mmio* bits.  I'm not aware of what's happening with the
patches that they depend on (which is why I recently asked the
question - again, I seem to be completely out of the loop due to
lack of Cc's).

So I'm just throwing my hands up and saying "I don't know what to
do" at this stage.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
