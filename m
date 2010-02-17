From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
	mapping API
Date: Wed, 17 Feb 2010 20:04:46 +0000
Message-ID: <20100217200445.GA29249@flint.arm.linux.org.uk>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com> <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com> <1265388234.14404.47.camel@mulgrave.site> <1265390403.7692.101.camel@pc1117.cambridge.arm.com> <1265391384.14404.53.camel@mulgrave.site> <1265645421.4020.119.camel@pc1117.cambridge.arm.com> <1265649274.6289.12.camel@mulgrave.site> <1265738604.8655.58.camel@pc1117.cambridge.arm.com> <1266397895.16346.267.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39136 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805Ab0BQUI3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Feb 2010 15:08:29 -0500
Content-Disposition: inline
In-Reply-To: <1266397895.16346.267.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Wed, Feb 17, 2010 at 08:11:35PM +1100, Benjamin Herrenschmidt wrote:
> In that case, I would recommend you look at how this is already dealt
> with on existing archs such as powerpc, using PG_arch1 in struct page to
> keep track of whether a given page is clean for execution and mapping
> pages that aren't non-exec so the kernel gets a chance to clean them
> once when execution happens.

That would be fine if we weren't already using PG_arch_1 for delaying
D-cache flushes for pages which aren't mapped, in the same way that
Sparc64 does.

That doesn't cover this case though - the problem is not I/D cache
coherency - the problem has manifested itself as data corruption when
userspace reads the page.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
