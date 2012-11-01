From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 1 Nov 2012 06:04:20 -0700
Message-ID: <20121101130420.GB20982@kroah.com>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
 <20121101103339.GD410@arwen.pp.htv.fi>
 <20121101105034.GE410@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121101105034.GE410-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 01, 2012 at 12:50:34PM +0200, Felipe Balbi wrote:
> On Thu, Nov 01, 2012 at 12:33:39PM +0200, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Nov 01, 2012 at 06:29:30PM +0800, kbuild test robot wrote:
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> > > head:   1789e52acc90c87484a109d6349eefe63cabb257
> > > commit: 1789e52acc90c87484a109d6349eefe63cabb257 [3/3] usb: phy: add R-Car USB phy driver
> > > config: make ARCH=cris allyesconfig
> > > 
> > > All error/warnings:
> > > 
> > > drivers/usb/phy/rcar-phy.c: In function 'rcar_usb_phy_init':
> > > drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32' [-Werror=implicit-function-declaration]
> > > drivers/usb/phy/rcar-phy.c:83:4: error: implicit declaration of function 'ioread32' [-Werror=implicit-function-declaration]
> > > cc1: some warnings being treated as errors
> > 
> > too bad that it compiles fine on x86 and ARM :-(
> > 
> > Kuninori, care to send me a fixup patch ? I guess using writel()/readl()
> > should do it ?!?
> 
> looks like this isn't enough. We have 6 arches which don't provide
> writel()/readl(), namely blackfin, c6x, openrisc, s390, score, and um.
> 
> Should those arches be fixed instead ? Don't we have a single
> memory-mapped access set of APIs which are supposed to be provided by
> all arches ?
> 
> Greg, you've been doing this for much more time then I have. Should all
> arches provide writeb/w/l/q and readb/w/l/q ??

I would think so, but I really don't know.

linux-arch people, what do we do about architectures that don't provide
these functions?  Just disable building the drivers for them, or do we
fix them somehow?

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
