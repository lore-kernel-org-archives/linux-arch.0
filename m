From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: + kmap_types-make-most-arches-use-generic-header-file.patch added to -mm tree
Date: Thu, 28 May 2009 22:11:56 +0000
Message-ID: <200905282211.58997.arnd@arndb.de>
References: <200905282131.n4SLV7rj025720@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54753 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbZE1WQd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2009 18:16:33 -0400
In-Reply-To: <200905282131.n4SLV7rj025720@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, randy.dunlap@oracle.com, cooloney@kernel.org, davem@davemloft.net, dhowells@redhat.com, geert@linux-m68k.org, hpa@zytor.com, ink@jurassic.park.msu.ru, kyle@mcmartin.ca, lethal@linux-sh.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, rth@twiddle.net, schwidefsky@de.ibm.com, starvik@axis.com, takata@linux-m32r.org, tglx@linutronix.de, tony.luck@intel.com, vapier@gentoo.org

On Thursday 28 May 2009 21:31:06 akpm@linux-foundation.org wrote:
> 
> The patch titled
>      kmap_types: make most arches use generic header file
> has been added to the -mm tree.  Its filename is
>      kmap_types-make-most-arches-use-generic-header-file.patch

Thanks for adding it back.

> Move the KM_FENCE_ macro additions into asm-generic/kmap_types.h,
> controlled by __WITH_KM_FENCE from each arch's kmap_types.h file.

I completely missed this part of the patch before. Is this actually useful?
All architectures that define it (x86 with a twist, the check for X86_32 is
an artifact from the x86 arch merge) do

#ifdef CONFIG_DEBUG_HIGHMEM
#define  __WITH_KM_FENCE
#endif

However: alpha, ia64, m32r, parisc and sh don't even support CONFIG_HIGHMEM
and therefore also can't set CONFIG_DEBUG_HIGHMEM. Conversely, mn10300 and
sparc can set CONFIG_DEBUG_HIGHMEM but don't get the extra checking
from KM_FENCE without this.

It seems to me that it would be at least as correct but simpler to just
leave the check for CONFIG_DEBUG_HIGHMEM.
 
> Would be nice to be able to add custom KM_types per arch, but I don't yet
> see a nice, clean way to do that.

FWIW, the only types that are not in the generic file right now are

arm: KM_L2_CACHE
powerpc: KM_PPC_SYNC_ICACHE, KM_PPC_SYNC_PAGE
um: KM_UML_USERCOPY

We could easily add these as KM_SYNC_ICACHE, KM_SYNC_DCACHE and
KM_UML_USERCOPY in the generic file and get rid of all architecture
specific types here.

	Arnd <><
