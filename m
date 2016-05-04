Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57573 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752560AbcEDNxt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 09:53:49 -0400
Date: Wed, 4 May 2016 15:53:45 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: kmap_atomic and preemption
Message-ID: <20160504155345.5fdd366e@free-electrons.com>
In-Reply-To: <20160504134729.GP3430@twins.programming.kicks-ass.net>
References: <5729D0F4.9090907@synopsys.com>
	<20160504134729.GP3430@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160504135345.SpzdxHJ-QzhjJMq29R4mDdgiAO6huTzWtTKhSSzafO8@z>

Hello,

On Wed, 4 May 2016 15:47:29 +0200, Peter Zijlstra wrote:

> static inline void *kmap_atomic(struct page *page)
> {
> 	preempt_disable();
> 	pagefault_disable();
> 	if (!PageHighMem(page))
> 		return page_address(page);
> 
> 	return __kmap_atomic(page);
> }

This is essentially what has been done on ARM in commit
9ff0bb5ba60638a688a46e93df8c5009896672eb, showing a pretty significant
improvement in network workloads.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
