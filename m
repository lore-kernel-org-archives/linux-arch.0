From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 12:42:21 +0100
Message-ID: <200906011242.22026.arnd@arndb.de>
References: <20090601082943.GA5550@flint.arm.linux.org.uk> <200906011141.33463.arnd@arndb.de> <20090601105851.GB25391@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:58192 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbZFALm2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 07:42:28 -0400
In-Reply-To: <20090601105851.GB25391@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 01 June 2009, Russell King wrote:

> I didn't say "for all architectures".  I said that the end conditions
> need to be the same no matter how DMA is done.
> 
> And yes, it does matter with some cache types.  VIPT aliasing caches
> and VIVT caches both need to ensure that condition is met, otherwise
> userspace doesn't see the data.

Ok, thanks for the explanation.

> While we can hand-wave and say "some other part of the code should
> handle this" I've had that disucssion several times, and that's where
> this requirement eventually was stated.  And, really, I'm not going
> to re-discuss it yet again - I really don't have time or motivation
> at present to be involved in yet another hand-waving egotistical
> debate over it.

I was not trying to start a debate over this, just being curious.

	Arnd <><
