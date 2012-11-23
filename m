From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Fri, 23 Nov 2012 16:47:00 +0000
Message-ID: <201211231647.00678.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091425.13492.arnd@arndb.de> <50AF9C06.3010705@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58805 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab2KWQrE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2012 11:47:04 -0500
In-Reply-To: <50AF9C06.3010705@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Friday 23 November 2012, James Hogan wrote:
> 
> On 09/11/12 14:25, Arnd Bergmann wrote:
> > On Wednesday 31 October 2012, James Hogan wrote:
> >> +static inline void
> >> +dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
> >> +                enum dma_data_direction direction)
> >> +{
> >> +       BUG_ON(!valid_dma_direction(direction));
> >> +       dma_sync_for_cpu((void *)bus_to_virt(dma_addr), size, direction);
> >> +}
> > 
> > bus_to_virt is deprecated an should not be visible to device drivers
> > any more for new stuff. Maybe you can remove the definition and introduce
> > a __bus_to_virt() function for internal use that also returns a pointer
> > type instead.
> 
> Is there any reason not to just directly use phys_to_virt (which
> bus_to_virt was defined as before)?

That should be fine in this case. It's just that device drivers must
not rely directly on a particular mapping between bus and virt addresses.
dma_map_single is are the right place to put this mapping.

	Arnd
