Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.17.162]:46147 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754833Ab0IMKcY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Sep 2010 06:32:24 -0400
Date: Mon, 13 Sep 2010 12:32:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH -tip -v4] irq_work: generic hard-irq context callbacks
Message-ID: <20100913123213.76b1b5fa@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <1284360648.3269.115.camel@yhuang-dev.sh.intel.com>
References: <1284360648.3269.115.camel@yhuang-dev.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Huang Ying <ying.huang@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, paulus <paulus@samba.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, dhowells <dhowells@redhat.com>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@mcmartin.ca>, davem <davem@davemloft.net>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20100913103213.toQzv2FinD_2kRzRtiY7YHcPzViO3VMC8D9pg9lRlNQ@z>

On Mon, 13 Sep 2010 14:50:48 +0800
Huang Ying <ying.huang@intel.com> wrote:

> From:  Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> In order for other NMI context users that want to run things from
> hard-IRQ context, extract the perf_event callback mechanism.
> 
> Huang Ying: some fixes
> 
> This patch is only tested on x86 platform.
> 
> 
> v4:
> 
> -rebased on latest -tip tree
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Signed-off-by: Huang Ying <ying.huang@intel.com>

On s390 I get compile errors:

include/linux/perf_event.h:464:29: error: asm/perf_event.h: No such file or directory

Not a good idea to completely remove the perf_event.h from arch/s390/include/asm.
With an empty header file the kernel at least compiles.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

