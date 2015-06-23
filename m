From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 10:26:24 +0100
Message-ID: <20150623092624.GG31504@arm.com>
References: <20150622133656.GG1583@arm.com>
 <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
 <20150623084905.GE31504@arm.com>
 <558920DD.6010505@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:50642 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbbFWJ01 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2015 05:26:27 -0400
Content-Disposition: inline
In-Reply-To: <558920DD.6010505@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Tue, Jun 23, 2015 at 10:03:25AM +0100, Vineet Gupta wrote:
> On Tuesday 23 June 2015 02:19 PM, Will Deacon wrote:
> >> +/*
> >> > + * MMIO can also get buffered/optimized in micro-arch, so barriers needed
> >> > + * Based on ARM model for the typical use case
> >> > + *
> >> > + *	<writel_relaxed DMA buffer>
> >> > + *	<writel MMIO "go" reg>
> >> > + *   or:
> >> > + *   	<readl MMIO "status" reg>
> >> > + *   	<readl_relaxed DMA buffer>
> > The writel_relaxed/readl_relaxed parts here would actually just be
> > bog-standard loads and stores to an in-memory buffer. I was trying too hard
> > to show the barrier semantics and accidentally turned the DMA buffers into
> > __iomem regions.
> 
> Not sure if I follow you completely :-)

D'oh, sorry.

> IMHO, It doesn't matter if we are dealing with a typical DMA buffer (cached) or a
> buffer descriptor (typically uncached unless there's hardware IO-coh or some
> such). Both the cases assume a vanilla ld/st to buffer (using relaxed API) with a
> surrounding MMIO access.

It's more that you should only pass __iomem pointers (i.e. stuff you got
back from something like ioremap) to readl_relaxed/writel_relaxed and that's
not typically how you would allocate your DMA buffer.

> > If you fix the comment:
> 
> Does this look better ?
> 
> - *	<writel_relaxed DMA buffer>
> + *	<writel_relaxed DMA buffer (cached or uncached)>

I'd just replace 'writel_relaxed' with whatever your store instruction is
(ST)?

Will
