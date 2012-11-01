From: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Date: Thu, 01 Nov 2012 15:53:43 +0000
Message-ID: <1351785223.2391.85.camel@dabdike.int.hansenpartnership.com>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
	 <20121101103339.GD410@arwen.pp.htv.fi>
	 <20121101105034.GE410@arwen.pp.htv.fi> <20121101130420.GB20982@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121101130420.GB20982-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Thu, 2012-11-01 at 06:04 -0700, Greg KH wrote:
> On Thu, Nov 01, 2012 at 12:50:34PM +0200, Felipe Balbi wrote:
> > On Thu, Nov 01, 2012 at 12:33:39PM +0200, Felipe Balbi wrote:
> > > Hi,
> > > 
> > > On Thu, Nov 01, 2012 at 06:29:30PM +0800, kbuild test robot wrote:
> > > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> > > > head:   1789e52acc90c87484a109d6349eefe63cabb257
> > > > commit: 1789e52acc90c87484a109d6349eefe63cabb257 [3/3] usb: phy: add R-Car USB phy driver
> > > > config: make ARCH=cris allyesconfig
> > > > 
> > > > All error/warnings:
> > > > 
> > > > drivers/usb/phy/rcar-phy.c: In function 'rcar_usb_phy_init':
> > > > drivers/usb/phy/rcar-phy.c:75:3: error: implicit declaration of function 'iowrite32' [-Werror=implicit-function-declaration]
> > > > drivers/usb/phy/rcar-phy.c:83:4: error: implicit declaration of function 'ioread32' [-Werror=implicit-function-declaration]
> > > > cc1: some warnings being treated as errors
> > > 
> > > too bad that it compiles fine on x86 and ARM :-(
> > > 
> > > Kuninori, care to send me a fixup patch ? I guess using writel()/readl()
> > > should do it ?!?
> > 
> > looks like this isn't enough. We have 6 arches which don't provide
> > writel()/readl(), namely blackfin, c6x, openrisc, s390, score, and um.
> > 
> > Should those arches be fixed instead ? Don't we have a single
> > memory-mapped access set of APIs which are supposed to be provided by
> > all arches ?
> > 
> > Greg, you've been doing this for much more time then I have. Should all
> > arches provide writeb/w/l/q and readb/w/l/q ??

Certainly not the q variants.  It's debatable on the l ones.

The reason for the q problem is that if the arch can achieve atomic bus
transactions for 8 bytes, that's fine, but if the arch can't do that,
it's up to the driver to decide what it needs.  Most can do two 4 byte
writes, but a few need the atomicity.  We can't decide that in the arch
so we'd have to assume the most extreme case, so using a spinlock around
the two 4 byte writes to ensure atomicity, which would be a killer for
performance.

> I would think so, but I really don't know.
> 
> linux-arch people, what do we do about architectures that don't provide
> these functions?  Just disable building the drivers for them, or do we
> fix them somehow?

A good driver has #if's for this case ... see for example

drivers/scsi/ipr.h

(ipr doesn't need atomicity, so it just defines writeq to be a pair of
writels.  See drivers/scsi/mpt2sas/mpt2sas_base.c for a driver that
requires atomicity.)

James


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
