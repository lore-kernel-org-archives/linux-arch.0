From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Wed, 22 Oct 2008 17:59:23 +0200
Message-ID: <20081022155923.GM23060@elte.hu>
References: <20081012054634.GA12535@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:51434 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224AbYJVP7e (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Oct 2008 11:59:34 -0400
Content-Disposition: inline
In-Reply-To: <20081012054634.GA12535@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, benh@kernel.crashing.org, Peter Zijlstra <a.p.zijlstra@chello.nl>


* Nick Piggin <npiggin@suse.de> wrote:

> Speed up generic mutex implementations.
> 
> - atomic operations which both modify the variable and return something imply
>   full smp memory barriers before and after the memory operations involved
>   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
>   they don't modify the target). See Documentation/atomic_ops.txt.
>   So remove extra barriers and branches.
>   
> - All architectures support atomic_cmpxchg. This has no relation to
>   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> 
> This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> to 203 cycles on a ppc970 system.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>

no objections here. Lets merge these two patches via the ppc tree, so 
that it gets testing on real hardware as well?

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
