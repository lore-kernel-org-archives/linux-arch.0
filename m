From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATH V2 1/6] mm: Introduce a general RCU get_user_pages_fast.
Date: Wed, 27 Aug 2014 14:14:45 +0100
Message-ID: <20140827131445.GB17601@arm.com>
References: <1408635812-31584-1-git-send-email-steve.capper@linaro.org>
 <1408635812-31584-2-git-send-email-steve.capper@linaro.org>
 <20140827085442.GD16376@arm.com>
 <20140827125027.GA7765@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:52178 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933270AbaH0NO1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Aug 2014 09:14:27 -0400
Content-Disposition: inline
In-Reply-To: <20140827125027.GA7765@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "gary.robertson@linaro.org" <gary.robertson@linaro.org>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "anders.roxell@linaro.org" <anders.roxell@linaro.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "dann.frazier@canonical.com" <dann.frazier@canonical.com>, Mark Rutland <Mark.Rutland@arm.com>, "mgorman@suse.de" <mgorman@suse.de>

On Wed, Aug 27, 2014 at 01:50:28PM +0100, Steve Capper wrote:
> On Wed, Aug 27, 2014 at 09:54:42AM +0100, Will Deacon wrote:
> > On Thu, Aug 21, 2014 at 04:43:27PM +0100, Steve Capper wrote:
> > > @@ -672,3 +676,277 @@ struct page *get_dump_page(unsigned long addr)
> > >  	return page;
> > >  }
> > >  #endif /* CONFIG_ELF_CORE */
> > > +
> > > +#ifdef CONFIG_HAVE_RCU_GUP
> > > +
> > > +#ifdef __HAVE_ARCH_PTE_SPECIAL
> > 
> > Do we actually require this (pte special) if hugepages are disabled or
> > not supported?
> 
> We need this logic if we want use fast_gup on normal pages safely. The special
> bit indicates that we should not attempt to take a reference to the underlying
> page.
> 
> Huge pages are guaranteed not to be special.

Gah, I somehow mixed up sp-litting and sp-ecial. Step away from the
computer.

In which case, the patch looks fine. You might need to repost with '[PATCH]'
instead of '[PATH]', in case you confused people's filters.

Will
