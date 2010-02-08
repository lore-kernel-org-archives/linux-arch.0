From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
	mapping API
Date: Mon, 8 Feb 2010 16:54:17 +0000
Message-ID: <20100208165417.GA29551@flint.arm.linux.org.uk>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com> <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com> <1265388234.14404.47.camel@mulgrave.site> <1265390403.7692.101.camel@pc1117.cambridge.arm.com> <1265391384.14404.53.camel@mulgrave.site> <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51427 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab0BHQye (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Feb 2010 11:54:34 -0500
Content-Disposition: inline
In-Reply-To: <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Mon, Feb 08, 2010 at 04:10:21PM +0000, Catalin Marinas wrote:
> The pio_data_direction could be dropped and use the DMA one. We could
> also use pio_kmap_read/pio_kmap_write or similar but we have to triple
> the number of functions, so I prefer the additional argument.

Do we need to do anything for reading a buffer for PIO _out_ to the
device?  My understanding is that this has never been a problem.

The only problem I'm aware of is where PIO writes to the kernel
mapping of a lowmem pages; highmem pages need the data flushed out
of the temporary atomic kmap mapping anyway.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
