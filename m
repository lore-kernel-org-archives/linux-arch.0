From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 06/25] mm: Add PG_ARCH_2 page flag
Date: Thu, 25 Jun 2020 18:10:19 +0100
Message-ID: <20200625170954.GD14812@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-7-catalin.marinas@arm.com>
 <20200624113307.6165b3db2404c9d37b870a90@linux-foundation.org>
 <20200624183647.GU21350@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406608AbgFYRKY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 13:10:24 -0400
Content-Disposition: inline
In-Reply-To: <20200624183647.GU21350@casper.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Steven Price <steven.price@arm.com>

On Wed, Jun 24, 2020 at 07:36:47PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 11:33:07AM -0700, Andrew Morton wrote:
> > On Wed, 24 Jun 2020 18:52:25 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > From: Steven Price <steven.price@arm.com>
> > > 
> > > For arm64 MTE support it is necessary to be able to mark pages that
> > > contain user space visible tags that will need to be saved/restored e.g.
> > > when swapped out.
> > > 
> > > To support this add a new arch specific flag (PG_ARCH_2) that arch code
> > > can opt into using ARCH_USES_PG_ARCH_2.
> > > 
> > > ...
> > >
> > > --- a/fs/proc/page.c
> > > +++ b/fs/proc/page.c
> > > @@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
> > >  	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
> > >  	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
> > >  	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
> > > +#ifdef CONFIG_ARCH_USES_PG_ARCH_2
> > > +	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
> > > +#endif
> > 
> > Do we need CONFIG_ARCH_USES_PG_ARCH_2?  What would be the downside to
> > giving every architecture a PG_arch_2, but only arm64 uses it (at
> > present)?
> 
> 32-bit architectures don't have space for it.  We could condition it on
> CONFIG_64BIT instead.

I'll this, though we'd still need some #ifdefs (OTOH, we get rid of the
Kconfig entry).

-- 
Catalin
