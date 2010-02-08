From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
 mapping API
Date: Mon, 08 Feb 2010 11:20:49 -0600
Message-ID: <1265649649.6289.19.camel@mulgrave.site>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <20100208165417.GA29551@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59479 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753574Ab0BHRUv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 12:20:51 -0500
In-Reply-To: <20100208165417.GA29551@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org

On Mon, 2010-02-08 at 16:54 +0000, Russell King wrote:
> On Mon, Feb 08, 2010 at 04:10:21PM +0000, Catalin Marinas wrote:
> > The pio_data_direction could be dropped and use the DMA one. We could
> > also use pio_kmap_read/pio_kmap_write or similar but we have to triple
> > the number of functions, so I prefer the additional argument.
> 
> Do we need to do anything for reading a buffer for PIO _out_ to the
> device?  My understanding is that this has never been a problem.

Before outbound PIO, you need to flush all the aliases before sending.
However, this should *already* be done in the block path, so for block
I/O it should be unnecessary, yes.  All we need to do on the TO_DEVICE
case should be map and unmap the page if it's highmem.

> The only problem I'm aware of is where PIO writes to the kernel
> mapping of a lowmem pages; highmem pages need the data flushed out
> of the temporary atomic kmap mapping anyway.

Not quite.  in the PIO FROM_DEVICE case, we've created a dirty kernel
alias by reading the data from the device and writing it via the kernel
mapping.  We have to flush that alias whether it exists as a highmem
mapping or as a simple offset mapping before userspace will see the
data.  The block API assumes the FROM_DEVICE transfer went straight from
the device into main memory and didn't go via the kernel alias, so the
block use case won't flush it.

Additionally, for architectures that don't promise no movein on a
flushed but untouched page (unlike parisc, which does), we might need to
invalidate all the user aliases before passing the page back to kill any
stale data that may have been speculated into the alias caches).

James
