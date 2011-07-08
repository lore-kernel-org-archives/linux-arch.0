From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/19] OpenRISC: DMA
Date: Fri, 8 Jul 2011 09:44:30 +0200
Message-ID: <201107080944.30330.arnd@arndb.de>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se> <201107051737.30120.arnd@arndb.de> <1310110579.3073.19.camel@jerome>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55384 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab1GHHpH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jul 2011 03:45:07 -0400
In-Reply-To: <1310110579.3073.19.camel@jerome>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Friday 08 July 2011 09:36:19 Jonas Bonn wrote:
> I put a bit more thought into what we actually need for DMA and came up
> with the implementation in this patch.  This is a lot simpler than what
> we had before, but it seems to fit nicely with the model that we have.
> 
> The jist of it is that allocation of coherent memory just needs to
> return pages with the cache-inhibit bit set so we now:
> 
> i)   call __get_free_pages (via alloc_pages_exact)
> ii)  set the CI bit on those pages
> iii) flush the pages from cache
> 
> This should mean that we don't have any conflicting page table entries
> for these pages anymore.
> 
> I'd appreciate if you could look over this implementation to make sure
> I haven't missed anything fundamental.

Looks ok to me. A few more points for future optimization though:

* If your CPU can do different page sizes, you should make the kernel
  mapping use the largest possible page size. This will however make
  the dma mapping part much harder.

* If you ever want to map a frame buffer with this, you should
  add a write-combining mapping type, uncached accesses are really
  slow.

* Cache coherency is good. If you can make the hardware do cache-coherent
  DMA, then just use cacheable pages for alloc_coherent.

	Arnd
