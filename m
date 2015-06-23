From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 20/28] ARCv2: barriers
Date: Tue, 23 Jun 2015 11:25:06 +0200
Message-ID: <20150623092506.GP19282@twins.programming.kicks-ass.net>
References: <20150622133656.GG1583@arm.com>
 <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:44171 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbbFWJZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jun 2015 05:25:23 -0400
Content-Disposition: inline
In-Reply-To: <1435046283-2073-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, arc-linux-dev@synopsys.com, Will Deacon <will.deacon@arm.com>

On Tue, Jun 23, 2015 at 01:28:03PM +0530, Vineet Gupta wrote:
> +/*
> + * MMIO can also get buffered/optimized in micro-arch, so barriers needed
> + * Based on ARM model for the typical use case
> + *
> + *	<writel_relaxed DMA buffer>
> + *	<writel MMIO "go" reg>
> + *   or:
> + *   	<readl MMIO "status" reg>
> + *   	<readl_relaxed DMA buffer>
> + *
> + * http://www.spinics.net/lists/kernel/msg2018397.html

	http://lkml.kernel.org/r/20150622133656.GG1583@arm.com

Might I suggest you use the above link. Since we control kernel.org we
have redirect that URL to a archive of our choosing. This keeps the
links working even if spinics.net or marc.info were to go belly up.
