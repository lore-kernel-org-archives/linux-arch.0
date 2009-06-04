From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] kmap_types: convert most arches to a single header file
Date: Thu, 4 Jun 2009 22:28:34 +0100
Message-ID: <200906042228.36571.arnd@arndb.de>
References: <4A280BB0.4030805@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:60957 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbZFDVbu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jun 2009 17:31:50 -0400
In-Reply-To: <4A280BB0.4030805@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Bryan Wu <cooloney@kernel.org>, Mikael Starvik <starvik@axis.com>, Hirokazu Takata <takata@linux-m32r.org>, Luck Tony <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>

On Thursday 04 June 2009, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> Subject: kmap_types: make most arches use generic header file
> 
> Convert most arches (*except frv*) to use asm-generic/kmap_types.h.
> Each arch still has its own kmap_types.h for customization if
> needed (like frv).
> 
> KM_FENCE is now controlled by CONFIG_HIGHMEM.
> 
> Built on x86_64, i386, mips, sparc32, sparc64,
> alpha, powerpc64, ia64, and m68k.
> 
> Note: Removed KM_PTE2 from generic kmap_types.h file; it was defined
> but not used by avr32.

Every change in here looks good to me now, so

Acked-by: Arnd Bergmann <arnd@arndb.de>

Two questions though:

1. The patch still conflicts with mine from the asm-generic
tree. Yours is better in multiple ways (cleans up all the
archs, adds the necessary types for ppc and arm), so should
I drop mine now? I guess I can also make my file identical
to yours so independent of who gets in first, there should be
a clean merge?

2. should the asm and powerpc bits go through the arch maintainer
trees? I guess since they are slightly more than an obvious
consolidation, at least an Ack from BenH and Russell would be
appropriate.

	Arnd <><
