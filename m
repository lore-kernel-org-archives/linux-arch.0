From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 1 Nov 2012 22:29:10 +0800
Message-ID: <20121101142910.GA8072@localhost>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
 <20121101103339.GD410@arwen.pp.htv.fi>
 <20121101105034.GE410@arwen.pp.htv.fi>
 <20121101130420.GB20982@kroah.com>
 <20121101132342.GE12489@arwen.pp.htv.fi>
 <CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36428 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761388Ab2KAO3P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Nov 2012 10:29:15 -0400
Content-Disposition: inline
In-Reply-To: <CAMo8BfLoU0GLpncX7YXy_VvveFnR6f6guPJTLNdtt3SWDK1fcg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: balbi@ti.com, Greg KH <gregkh@linuxfoundation.org>, linux-arch@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org

On Thu, Nov 01, 2012 at 04:47:14PM +0300, Max Filippov wrote:
> On Thu, Nov 1, 2012 at 5:23 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Nov 01, 2012 at 06:04:20AM -0700, Greg KH wrote:
> >> On Thu, Nov 01, 2012 at 12:50:34PM +0200, Felipe Balbi wrote:
> >> > On Thu, Nov 01, 2012 at 12:33:39PM +0200, Felipe Balbi wrote:
> >> > > Hi,
> >> > >
> >> > > On Thu, Nov 01, 2012 at 06:29:30PM +0800, kbuild test robot wrote:
> >> > > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> >> > > > head:   1789e52acc90c87484a109d6349eefe63cabb257
> >> > > > commit: 1789e52acc90c87484a109d6349eefe63cabb257 [3/3] usb: phy: add R-Car USB phy driver
> >> > > > config: make ARCH=cris allyesconfig
> >> > > >
> >> > > > All error/warnings:
> >> > > >
> >> > > > drivers/usb/phy/rcar-phy.c: In function 'rcar_usb_phy_init':
> >> > > > drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32' [-Werror=implicit-function-declaration]
> >> > > > drivers/usb/phy/rcar-phy.c:83:4: error: implicit declaration of function 'ioread32' [-Werror=implicit-function-declaration]
> >> > > > cc1: some warnings being treated as errors
> >> > >
> >> > > too bad that it compiles fine on x86 and ARM :-(
> >> > >
> >> > > Kuninori, care to send me a fixup patch ? I guess using writel()/readl()
> >> > > should do it ?!?
> >> >
> >> > looks like this isn't enough. We have 6 arches which don't provide
> >> > writel()/readl(), namely blackfin, c6x, openrisc, s390, score, and um.
> >> >
> >> > Should those arches be fixed instead ? Don't we have a single
> >> > memory-mapped access set of APIs which are supposed to be provided by
> >> > all arches ?
> >> >
> >> > Greg, you've been doing this for much more time then I have. Should all
> >> > arches provide writeb/w/l/q and readb/w/l/q ??
> >>
> >> I would think so, but I really don't know.
> >>
> >> linux-arch people, what do we do about architectures that don't provide
> >> these functions?  Just disable building the drivers for them, or do we
> >> fix them somehow?
> >
> > btw, only alpha and x86 seem to be providing all of those, but if you
> > look into our documentation, it's said that drivers are supposed to use
> > write/read{b,w,l,q} for all memory-mapped io. I'd expect all platforms
> > to provide those even if just to allow compilation of drivers.
> 
> Strange, AFAICS architectures that use asm-generic/io.h (blackfin, openrisc,
> score, unicore32 and xtensa) also provide those functions.

FYI, build log shows that the errors only happen for cris among all
the allyesconfig builds: 

        cris-allyesconfig
        parisc-allyesconfig
        sparc64-allyesconfig
        xtensa-allyesconfig
        sparc-allyesconfig
        m68k-allyesconfig
        x86_64-allyesconfig
        powerpc-allyesconfig
        mips-allyesconfig

Thanks,
Fengguang
