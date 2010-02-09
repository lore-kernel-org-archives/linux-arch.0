From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
	mapping API
Date: Tue, 09 Feb 2010 18:03:24 +0000
Message-ID: <1265738604.8655.58.camel@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <1265649274.6289.12.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:59081 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754995Ab0BISD3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Feb 2010 13:03:29 -0500
In-Reply-To: <1265649274.6289.12.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-arch@vger.kernel.org

On Mon, 2010-02-08 at 17:14 +0000, James Bottomley wrote:
> On Mon, 2010-02-08 at 16:10 +0000, Catalin Marinas wrote:
> 
> This API would have to cope with highmem too ... and because of the
> limited mappings available, we can't just map an arbitrary sized buffer
> (especially in atomics where the number of available slots is often only
> two).
> 
> > static inline void *pio_map_range(void *start, size_t size,
> >                                 enum pio_data_direction dir)
> > {
> >       return start;
> > }
> >
> > static inline void pio_unmap_range(void *start, size_t size,
> >                                  enum pio_data_direction dir)
> > {
> > }
> 
> I think really for range PIO, we need helpers to map and unmap a page at
> a time ... sort of like the for_each_sg approach except this time we
> loop over the pages in the range mapping and unmapping a single one.

These were not intended to create any additional mapping, more like the
dma_map_single() functions and only do the necessary flushing.

AFAICT, an HCD driver would call the pio_map_range() once to get the
address of the buffer and than wait for it to be filled in (e.g. via
interrupts). When it is full, it would call pio_unmap_range(). So even
if we do it per page, you still need to map the same amount of memory,
unless we modify the HCD drivers but I don't think this would be very
popular.

Maybe the name choosing is wrong. Would something like pio_begin() and
pio_end() work better for already mapped buffers?

-- 
Catalin
