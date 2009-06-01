From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:41:32 +0100
Message-ID: <200906011141.33463.arnd@arndb.de>
References: <20090601082943.GA5550@flint.arm.linux.org.uk> <20090601183323V.fujita.tomonori@lab.ntt.co.jp> <20090601101405.GA19806@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52309 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520AbZFAKln (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:41:43 -0400
In-Reply-To: <20090601101405.GA19806@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 01 June 2009, Russell King wrote:

> So, on a non-DMA coherent cache architecture, when DMA is normally
> performed the data ends up in RAM with the cache flushed for that
> region.  If, instead dma_map_single uses a bounce buffer to do that
> DMA, then the same needs to be true of the original buffer - the
> data needs to be in RAM with the cache flushed.

While this seems logical from a correctness perspective, I would
like to understand why it actually matters. Flushing the cache on
the original buffer will impact performance but doesn't generally
make a difference to users. In cases where you need the cache
to be flushed for aliasing reasons (VIPT caches...), the architecture
specific code should flush that buffer somewhere, but do we really
need to flush it for all architectures?

	Arnd <><
