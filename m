Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:41416 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S932292AbWGCXfe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 Jul 2006 19:35:34 -0400
Date: Mon, 3 Jul 2006 17:35:33 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Message-ID: <20060703233533.GE1605@parisc-linux.org>
References: <1151670404.11575.5.camel@localhost> <200606301605.53258.ak@suse.de> <1151677236.29984.11.camel@localhost> <200607040115.18194.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607040115.18194.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: schwidefsky@de.ibm.com, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jul 04, 2006 at 01:15:16AM +0200, Arnd Bergmann wrote:
> I would assume that all of these depend on memory mapped I/O
> access. So they might be more correctly depend on CONFIG_MMIO.

We don't (yet) have a CONFIG_MMIO.  If we were to have one, I would
expect it to be akin to SCSI_SYM53C8XX_MMIO, VIA_RHINE_MMIO,
SUNDANCE_MMIO and TULIP_MMIO.  ie indicating a preference between PIO
and MMIO rather than indicating the availability of MMIO.
