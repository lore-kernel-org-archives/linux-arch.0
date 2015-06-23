From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 14:33:25 +0530
Message-ID: <558920DD.6010505@synopsys.com>
References: <20150622133656.GG1583@arm.com> <1435046283-2073-1-git-send-email-vgupta@synopsys.com> <20150623084905.GE31504@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:40955 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbbFWJDo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2015 05:03:44 -0400
In-Reply-To: <20150623084905.GE31504@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi Will,

On Tuesday 23 June 2015 02:19 PM, Will Deacon wrote:
>> +/*
>> > + * MMIO can also get buffered/optimized in micro-arch, so barriers needed
>> > + * Based on ARM model for the typical use case
>> > + *
>> > + *	<writel_relaxed DMA buffer>
>> > + *	<writel MMIO "go" reg>
>> > + *   or:
>> > + *   	<readl MMIO "status" reg>
>> > + *   	<readl_relaxed DMA buffer>
> The writel_relaxed/readl_relaxed parts here would actually just be
> bog-standard loads and stores to an in-memory buffer. I was trying too hard
> to show the barrier semantics and accidentally turned the DMA buffers into
> __iomem regions.

Not sure if I follow you completely :-)

IMHO, It doesn't matter if we are dealing with a typical DMA buffer (cached) or a
buffer descriptor (typically uncached unless there's hardware IO-coh or some
such). Both the cases assume a vanilla ld/st to buffer (using relaxed API) with a
surrounding MMIO access.

> 
> If you fix the comment:

Does this look better ?

- *	<writel_relaxed DMA buffer>
+ *	<writel_relaxed DMA buffer (cached or uncached)>

> 
>   Reviewed-by: Will Deacon <will.deacon@arm.com>
> 
> Sorry for messing you about.

NP.

-Vineet
