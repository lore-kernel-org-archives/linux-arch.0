From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
 mapping API
Date: Wed, 17 Feb 2010 20:11:35 +1100
Message-ID: <1266397895.16346.267.camel@pasglop>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <1265649274.6289.12.camel@mulgrave.site>
	 <1265738604.8655.58.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60240 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934191Ab0BQJLy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Feb 2010 04:11:54 -0500
In-Reply-To: <1265738604.8655.58.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Tue, 2010-02-09 at 18:03 +0000, Catalin Marinas wrote:
> 
> These were not intended to create any additional mapping, more like
> the
> dma_map_single() functions and only do the necessary flushing.
> 
> AFAICT, an HCD driver would call the pio_map_range() once to get the
> address of the buffer and than wait for it to be filled in (e.g. via
> interrupts). When it is full, it would call pio_unmap_range(). So even
> if we do it per page, you still need to map the same amount of memory,
> unless we modify the HCD drivers but I don't think this would be very
> popular.
> 
> Maybe the name choosing is wrong. Would something like pio_begin() and
> pio_end() work better for already mapped buffers? 

From your initial email, your problem isn't a VIVT cache aliasing but an
I$/D$ cache coherency problem with PIPT right ?

In that case, I would recommend you look at how this is already dealt
with on existing archs such as powerpc, using PG_arch1 in struct page to
keep track of whether a given page is clean for execution and mapping
pages that aren't non-exec so the kernel gets a chance to clean them
once when execution happens.

We have some faster path nowadays to do that on the first fault which
you take anyways (at least most of the time) at set_pte() time to avoid
double faults so the cost is minimum I believe.

Cheers,
Ben.
