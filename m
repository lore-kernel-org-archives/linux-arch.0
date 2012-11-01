Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:38026 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936020Ab2KAPxr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 11:53:47 -0400
Message-ID: <1351785223.2391.85.camel@dabdike.int.hansenpartnership.com>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 01 Nov 2012 15:53:43 +0000
In-Reply-To: <20121101130420.GB20982@kroah.com>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
	 <20121101103339.GD410@arwen.pp.htv.fi>
	 <20121101105034.GE410@arwen.pp.htv.fi> <20121101130420.GB20982@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-arch@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org
Message-ID: <20121101155343.7rdAPbhb-dLk5r6XDj66ZOhtTv1b37AAOc1xbcieFEE@z>

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


