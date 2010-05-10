From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH] Update the cachetlb.txt file WRT
 flush_dcache_pageand update_mmu_cache
Date: Mon, 10 May 2010 07:03:26 -0700 (PDT)
Message-ID: <20100510.070326.146087861.davem@davemloft.net>
References: <1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
	<20100510115552.GD10452@parisc-linux.org>
	<1273500010.10282.25.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:57264
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754878Ab0EJODU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 May 2010 10:03:20 -0400
In-Reply-To: <1273500010.10282.25.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com
Cc: matthew@wil.cx, fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, benh@kernel.crashing.org, rmk@arm.linux.org.uk

From: Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 10 May 2010 15:00:10 +0100

> 3rd point above would help with the D-cache aliasing. Does the I/D cache
> coherency need to be handled differently? On PIPT Harvard architectures,
> we don't actually have D-cache aliasing but we may end up flushing too
> much in kunmap() just in case such page would be mapped in user space
> with executable permission.

You can handle this by having an "I-cache clean" bit in the page.
When you kmap/kunmap, simply force this bit clear.

In update_mmu_cache() or set_pte_at() you'll see when a page gets
into userspace with execute permission, and if the I-cache bit
is clear you can do the flush then and set the "I-cache clean"
bit.
