From: David Miller <davem@davemloft.net>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 14:57:41 -0700 (PDT)
Message-ID: <20080912.145741.59974282.davem@davemloft.net>
References: <20080912025733.E55F415420D@magilla.localdomain>
	<20080912131351.GA31545@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53873
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755626AbYILV5s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Sep 2008 17:57:48 -0400
In-Reply-To: <20080912131351.GA31545@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rmk+lkml@arm.linux.org.uk
Cc: roland@redhat.com, linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 12 Sep 2008 14:13:51 +0100

> However, in looking at other architectures, I notice that sparc does this
> when initializing its regsets:
> 
>                 .n = 38 * sizeof(u32),
>                 .size = sizeof(u32), .align = sizeof(u32),
> 
> and sparc64:
> 
>                 .n = 36 * sizeof(u64),
>                 .size = sizeof(u64), .align = sizeof(u64),
> 
> which, given that fs/binfmt_elf.c does this:
> 
>                         size_t size = regset->n * regset->size;
>                         void *data = kmalloc(size, GFP_KERNEL);
>                         if (unlikely(!data))
>                                 return 0;
> 
> means sparc ends up allocating 38 * sizeof(u32) * sizeof(u32), and
> sparc64 ends up with 36 * sizeof(u64) * sizeof(u64), which must surely
> be wrong?

Yep, definitely a bug, good catch.  I guess, better to allocate
too much by accident rather than too little in this case :-)

I'll fix this up, thanks!
