Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:36304 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751089AbWGDSJz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 Jul 2006 14:09:55 -0400
Date: Tue, 4 Jul 2006 12:09:53 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Message-ID: <20060704180953.GI1605@parisc-linux.org>
References: <1151670404.11575.5.camel@localhost> <200607040115.18194.arnd@arndb.de> <20060703233533.GE1605@parisc-linux.org> <200607041442.03913.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607041442.03913.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: schwidefsky@de.ibm.com, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 04, 2006 at 02:42:03PM +0200, Arnd Bergmann wrote:
> On Tuesday 04 July 2006 01:35, Matthew Wilcox wrote:
> > We don't (yet) have a CONFIG_MMIO. ?If we were to have one, I would
> > expect it to be akin to SCSI_SYM53C8XX_MMIO, VIA_RHINE_MMIO,
> > SUNDANCE_MMIO and TULIP_MMIO. ?ie indicating a preference between PIO
> > and MMIO rather than indicating the availability of MMIO.
> 
> Hmm, maybe my terminology wasn't so good, at least you misunderstood
> what I wanted to express. PIO is more or less a 386ism, so I tend to
> view that as a special case of MMIO. The point with  s390 is that there
> is neither PIO nor MMIO, which really makes it impossible to use most
> of the device drivers, even if you could connect the hardware ;-).

I understood what you wanted; I was just explaining why it's a bad name.
CONFIG_STD_IO might be a good name.  CONFIG_PCI_IO might be confusing.

