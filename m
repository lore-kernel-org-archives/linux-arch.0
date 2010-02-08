From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the
	PIOmapping API
Date: Mon, 08 Feb 2010 18:02:51 +0000
Message-ID: <1265652171.4020.165.camel@pc1117.cambridge.arm.com>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <20100208165417.GA29551@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41218 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751221Ab0BHSC5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 13:02:57 -0500
In-Reply-To: <20100208165417.GA29551@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Mon, 2010-02-08 at 16:54 +0000, Russell King wrote:
> On Mon, Feb 08, 2010 at 04:10:21PM +0000, Catalin Marinas wrote:
> > The pio_data_direction could be dropped and use the DMA one. We could
> > also use pio_kmap_read/pio_kmap_write or similar but we have to triple
> > the number of functions, so I prefer the additional argument.
> 
> Do we need to do anything for reading a buffer for PIO _out_ to the
> device?  My understanding is that this has never been a problem.

With PIPT caches there is no need for any flushing on the TO_DEVICE case
but VIPT may need this. As James said, it should already be handled in
the block path (though I haven't found where exactly).

But I added the functions for symmetry anyway.

> The only problem I'm aware of is where PIO writes to the kernel
> mapping of a lowmem pages; highmem pages need the data flushed out
> of the temporary atomic kmap mapping anyway.

If we do cache flushing in kunmap() we wouldn't need an additional cache
flushing for highmem pages, so you can implement pio_kunmap()
accordingly. James' point in a previous e-mail was that he doesn't want
drivers to have "if (!PageHighMem(page))".

Now, the ARM kunmap() function doesn't seem to do any flushing, only
kunmap_atomic(). Do I miss anything?

Also, for PIPT caches we don't actually create any D-cache aliases with
kmap, so I'm not sure why we need to always flush the cache in kunmap().

-- 
Catalin
