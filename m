Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:44568 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab2KANEW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 09:04:22 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1157566dak.19
        for <linux-arch@vger.kernel.org>; Thu, 01 Nov 2012 06:04:21 -0700 (PDT)
Date: Thu, 1 Nov 2012 06:04:20 -0700
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [balbi-usb:xceiv 3/3] drivers/usb/phy/rcar-phy.c:75:3: error:
 implicit declaration of function 'iowrite32'
Message-ID: <20121101130420.GB20982@kroah.com>
References: <50924f0a.QuF7xjrp4IUSKMwd%fengguang.wu@intel.com>
 <20121101103339.GD410@arwen.pp.htv.fi>
 <20121101105034.GE410@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121101105034.GE410@arwen.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Felipe Balbi <balbi@ti.com>, linux-arch@vger.kernel.org
Cc: kbuild test robot <fengguang.wu@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-usb@vger.kernel.org
Message-ID: <20121101130420.GnpmDMXuVCCi5MqpDUsQitYITZvkQUT3LpRhGSHbEc4@z>

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
