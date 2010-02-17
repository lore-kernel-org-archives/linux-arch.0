From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH 2/4] pio-mapping: Add ARM support for the PIO
 mapping API
Date: Thu, 18 Feb 2010 07:39:39 +1100
Message-ID: <1266439179.16346.287.camel@pasglop>
References: <20100205163044.30827.10915.stgit@pc1117.cambridge.arm.com>
	 <20100205163154.30827.6636.stgit@pc1117.cambridge.arm.com>
	 <1265388234.14404.47.camel@mulgrave.site>
	 <1265390403.7692.101.camel@pc1117.cambridge.arm.com>
	 <1265391384.14404.53.camel@mulgrave.site>
	 <1265645421.4020.119.camel@pc1117.cambridge.arm.com>
	 <1265649274.6289.12.camel@mulgrave.site>
	 <1265738604.8655.58.camel@pc1117.cambridge.arm.com>
	 <1266397895.16346.267.camel@pasglop>
	 <20100217200445.GA29249@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36514 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756020Ab0BQUo6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Feb 2010 15:44:58 -0500
In-Reply-To: <20100217200445.GA29249@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-arch@vger.kernel.org

On Wed, 2010-02-17 at 20:04 +0000, Russell King wrote:
> 
> That would be fine if we weren't already using PG_arch_1 for delaying
> D-cache flushes for pages which aren't mapped, in the same way that
> Sparc64 does.

Interesting. Maybe we need more arch bits in there :-)

> That doesn't cover this case though - the problem is not I/D cache
> coherency - the problem has manifested itself as data corruption when
> userspace reads the page.

Yup, let's stick to the other thread. I still don't see why a PIO
mapping API is needed, from what I've read so far, it's a case of
mis-using the existing DMA API that could be fixed at the driver level.
No ?

Cheers,
Ben.
