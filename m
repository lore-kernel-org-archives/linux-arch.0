From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:58:51 +0100
Message-ID: <20090601105851.GB25391@flint.arm.linux.org.uk>
References: <20090601082943.GA5550@flint.arm.linux.org.uk> <20090601183323V.fujita.tomonori@lab.ntt.co.jp> <20090601101405.GA19806@flint.arm.linux.org.uk> <200906011141.33463.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45851 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346AbZFAK7G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:59:06 -0400
Content-Disposition: inline
In-Reply-To: <200906011141.33463.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Jun 01, 2009 at 11:41:32AM +0100, Arnd Bergmann wrote:
> On Monday 01 June 2009, Russell King wrote:
> 
> > So, on a non-DMA coherent cache architecture, when DMA is normally
> > performed the data ends up in RAM with the cache flushed for that
> > region.  If, instead dma_map_single uses a bounce buffer to do that
> > DMA, then the same needs to be true of the original buffer - the
> > data needs to be in RAM with the cache flushed.
> 
> While this seems logical from a correctness perspective, I would
> like to understand why it actually matters. Flushing the cache on
> the original buffer will impact performance but doesn't generally
> make a difference to users. In cases where you need the cache
> to be flushed for aliasing reasons (VIPT caches...), the architecture
> specific code should flush that buffer somewhere, but do we really
> need to flush it for all architectures?

I didn't say "for all architectures".  I said that the end conditions
need to be the same no matter how DMA is done.

And yes, it does matter with some cache types.  VIPT aliasing caches
and VIVT caches both need to ensure that condition is met, otherwise
userspace doesn't see the data.

While we can hand-wave and say "some other part of the code should
handle this" I've had that disucssion several times, and that's where
this requirement eventually was stated.  And, really, I'm not going
to re-discuss it yet again - I really don't have time or motivation
at present to be involved in yet another hand-waving egotistical
debate over it.

Last time I got accused of not being helpful because I wouldn't test
a patch - and the reason I couldn't test the patch was because I don't
have the hardware which exhibited the problem.  Duh.

So, let's leave sleeping dogs to continue their deep sleep.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
