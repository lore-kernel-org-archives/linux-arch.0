Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32793 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbZFAI3z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 04:29:55 -0400
Date: Mon, 1 Jun 2009 09:29:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Message-ID: <20090601082943.GA5550@flint.arm.linux.org.uk>
References: <200905282104.55818.arnd@arndb.de> <20090601130319A.fujita.tomonori@lab.ntt.co.jp> <20090601075114.GA29107@flint.arm.linux.org.uk> <20090601170847V.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090601170847V.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090601082943.x5RbTvEjrcIfxIzqIfDvCYmFSoXdXStcoD-myO7GRnE@z>

On Mon, Jun 01, 2009 at 05:08:09PM +0900, FUJITA Tomonori wrote:
> This adds a version of the dma-mapping API to asm-generic that can be
> used by most architectures that only need a linear mapping.

It depends what is meant by "linear mapping".

If that's just a way of saying "all that needs to be done for the
DMA streaming APIs is to flush the cache" then the vast majority of
ARMs fall into that category.

The DMA bounce code is a broken design concept that really needs to
be put to death.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
