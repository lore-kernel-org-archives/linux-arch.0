Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:30699 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932243AbWGDMmM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2006 08:42:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Tue, 4 Jul 2006 14:42:03 +0200
References: <1151670404.11575.5.camel@localhost> <200607040115.18194.arnd@arndb.de> <20060703233533.GE1605@parisc-linux.org>
In-Reply-To: <20060703233533.GE1605@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607041442.03913.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: schwidefsky@de.ibm.com, Andi Kleen <ak@suse.de>, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Tuesday 04 July 2006 01:35, Matthew Wilcox wrote:
> We don't (yet) have a CONFIG_MMIO.  If we were to have one, I would
> expect it to be akin to SCSI_SYM53C8XX_MMIO, VIA_RHINE_MMIO,
> SUNDANCE_MMIO and TULIP_MMIO.  ie indicating a preference between PIO
> and MMIO rather than indicating the availability of MMIO.

Hmm, maybe my terminology wasn't so good, at least you misunderstood
what I wanted to express. PIO is more or less a 386ism, so I tend to
view that as a special case of MMIO. The point with  s390 is that there
is neither PIO nor MMIO, which really makes it impossible to use most
of the device drivers, even if you could connect the hardware ;-).

	Arnd <><
