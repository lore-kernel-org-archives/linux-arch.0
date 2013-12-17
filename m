From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 [resend] 05/18] smp, ARM64: kill SMP single function
 call interrupt
Date: Tue, 17 Dec 2013 17:16:25 +0000
Message-ID: <20131217171625.GE349@mudshark.cambridge.arm.com>
References: <1387125400-28849-1-git-send-email-liuj97@gmail.com>
 <1387125400-28849-6-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:57738 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753933Ab3LQRQ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Dec 2013 12:16:28 -0500
Content-Disposition: inline
In-Reply-To: <1387125400-28849-6-git-send-email-liuj97@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiang Liu <liuj97@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shaohua Li <shli@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Javi Merino <Javi.Merino@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <trivial@kernel.org>, Wang YanQing <udknight@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Sun, Dec 15, 2013 at 04:36:27PM +0000, Jiang Liu wrote:
> Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
> similar to smp_call_function_single()" has unified the way to handle
> single and multiple cross-CPU function calls. Now only one interrupt
> is needed for architecture specific code to support generic SMP function
> call interfaces, so kill the redundant single function call interrupt.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shaohua Li <shli@kernel.org>
> Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Jiri Kosina <trivial@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  arch/arm64/include/asm/hardirq.h |  2 +-
>  arch/arm64/kernel/smp.c          | 10 +---------
>  2 files changed, 2 insertions(+), 10 deletions(-)

  Acked-by: Will Deacon <will.deacon@arm.com>

I assume you're taking this series via some other route (than the arch/
trees) in order to deal with any core dependencies?

Will
