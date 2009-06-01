From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:43:53 +0100
Message-ID: <20090601104353.GA25391@flint.arm.linux.org.uk>
References: <200905282104.55818.arnd@arndb.de> <20090601170847V.fujita.tomonori@lab.ntt.co.jp> <20090601082943.GA5550@flint.arm.linux.org.uk> <200906011128.10670.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38079 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756956AbZFAKoH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:44:07 -0400
Content-Disposition: inline
In-Reply-To: <200906011128.10670.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jun 01, 2009 at 11:28:09AM +0100, Arnd Bergmann wrote:
> On Monday 01 June 2009, Russell King wrote:
> > On Mon, Jun 01, 2009 at 05:08:09PM +0900, FUJITA Tomonori wrote:
> > > This adds a version of the dma-mapping API to asm-generic that can be
> > > used by most architectures that only need a linear mapping.
> > 
> > It depends what is meant by "linear mapping".
> > 
> > If that's just a way of saying "all that needs to be done for the
> > DMA streaming APIs is to flush the cache" then the vast majority of
> > ARMs fall into that category.
> 
> Right. You can probably split out the arm dma-mapping.h implementation
> into the dmabounce version and a version that falls back to my
> asm-generic code.
> 
> One feature that the arm code currently has that I'm still missing is
> highmem support, which seems to be relatively complex in arm
> (three different implementations). Not sure how to best fit that in there.

Err - there's only one highmem implementation on ARM.

Anyway, as I hinted, things in this area will most likely become more
complex in the near future, so any unification of the ARM dma-mapping
will have to be undone.

Let's wait for the ARMv7 support to mature before trying to unify too
much.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
