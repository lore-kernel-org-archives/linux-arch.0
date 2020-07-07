From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Date: Tue, 7 Jul 2020 18:46:12 +0100
Message-ID: <20200707174612.GC32331@gaia>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com>
 <20200707173617.GA32331@gaia>
 <d26f23960443a7f270847c90242e07ab@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727777AbgGGRqT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 13:46:19 -0400
Content-Disposition: inline
In-Reply-To: <d26f23960443a7f270847c90242e07ab@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org, suzuki.poulose@arm.com, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On Tue, Jul 07, 2020 at 06:43:35PM +0100, Marc Zyngier wrote:
> On 2020-07-07 18:36, Catalin Marinas wrote:
> > On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
> > > @@ -59,6 +69,47 @@
> > >  		__ta;						\
> > >  	})
> > > 
> > > +/*
> > > + * __TG defines translation granule of the system, which is decided
> > > by
> > > + * PAGE_SHIFT.  Used by TTL.
> > > + *  - 4KB	: 1
> > > + *  - 16KB	: 2
> > > + *  - 64KB	: 3
> > > + */
> > > +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)
> > 
> > Nitpick: maybe something like __TLBI_TG to avoid clashes in case someone
> > else defines a __TG macro.
> 
> I have commented on this in the past, and still maintain that this
> would be better served by a switch statement similar to what is used
> for TTL already (I don't think this magic formula exists in the
> ARM ARM).

Good point, it would be cleaner indeed.

-- 
Catalin
