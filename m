From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] kmap_types: convert most arches to a single header file
Date: Fri, 5 Jun 2009 08:09:07 +0100
Message-ID: <200906050809.09856.arnd@arndb.de>
References: <4A280BB0.4030805@oracle.com> <200906042228.36571.arnd@arndb.de> <4A28539B.5050200@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49802 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZFEHLJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2009 03:11:09 -0400
In-Reply-To: <4A28539B.5050200@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Bryan Wu <cooloney@kernel.org>, Mikael Starvik <starvik@axis.com>, Hirokazu Takata <takata@linux-m32r.org>, Luck Tony <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>

On Friday 05 June 2009, Randy Dunlap wrote:
> 
> > 1. The patch still conflicts with mine from the asm-generic
> > tree. Yours is better in multiple ways (cleans up all the
> > archs, adds the necessary types for ppc and arm), so should
> > I drop mine now? I guess I can also make my file identical
> > to yours so independent of who gets in first, there should be
> > a clean merge?
> 
> or you can take my patch into your asm-generic patchset.  :)

I've thought about that, but for 2.6.31, I'd like to only do
the first half of adding ~50 files to include/asm-generic/,
and then work with the arch maintainers on the second half,
removing the code from their directories for 2.6.32, so this
doesn't fit that well.

	Arnd <><
