From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/8] ARCv2: perf: Support sampling events using overflow
 interrupts
Date: Mon, 15 Jun 2015 18:25:25 +0200
Message-ID: <20150615162525.GH3644@twins.programming.kicks-ass.net>
References: <1433852372-29494-1-git-send-email-vgupta@synopsys.com>
 <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40102 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754213AbbFOQZk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2015 12:25:40 -0400
Content-Disposition: inline
In-Reply-To: <1433852372-29494-5-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, arc-linux-dev@synopsys.com, Arnaldo Carvalho de Melo <acme@kernel.org>

On Tue, Jun 09, 2015 at 05:49:28PM +0530, Vineet Gupta wrote:
> +	if (arc_pmu->has_interrupts) {
> +		int irq = platform_get_irq(pdev, 0);

Hmm, so you're requesting a regular interrupt.

I see your architecture has IRQ priorities, could you play games and
create NMIs using those?

For example, never mask L1 (assuming that's the highest priority) and
treat that as an NMI.
