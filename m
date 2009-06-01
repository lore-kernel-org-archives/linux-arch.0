From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:28:09 +0100
Message-ID: <200906011128.10670.arnd@arndb.de>
References: <200905282104.55818.arnd@arndb.de> <20090601170847V.fujita.tomonori@lab.ntt.co.jp> <20090601082943.GA5550@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65084 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbZFAK2T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:28:19 -0400
In-Reply-To: <20090601082943.GA5550@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 01 June 2009, Russell King wrote:
> On Mon, Jun 01, 2009 at 05:08:09PM +0900, FUJITA Tomonori wrote:
> > This adds a version of the dma-mapping API to asm-generic that can be
> > used by most architectures that only need a linear mapping.
> 
> It depends what is meant by "linear mapping".
> 
> If that's just a way of saying "all that needs to be done for the
> DMA streaming APIs is to flush the cache" then the vast majority of
> ARMs fall into that category.

Right. You can probably split out the arm dma-mapping.h implementation
into the dmabounce version and a version that falls back to my
asm-generic code.

One feature that the arm code currently has that I'm still missing is
highmem support, which seems to be relatively complex in arm
(three different implementations). Not sure how to best fit that in there.

	Arnd <><
