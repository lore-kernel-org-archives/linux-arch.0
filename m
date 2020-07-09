From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/6] powerpc/64s: implement queued spinlocks and rwlocks
Date: Thu, 09 Jul 2020 20:20:25 +1000
Message-ID: <877dvdvvkm.fsf@mpe.ellerman.id.au>
References: <20200706043540.1563616-1-npiggin@gmail.com> <20200706043540.1563616-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:48913 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgGIKSL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 06:18:11 -0400
In-Reply-To: <20200706043540.1563616-5-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> These have shown significantly improved performance and fairness when
> spinlock contention is moderate to high on very large systems.
>
>  [ Numbers hopefully forthcoming after more testing, but initial
>    results look good ]

Would be good to have something here, even if it's preliminary.

> Thanks to the fast path, single threaded performance is not noticably
> hurt.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/Kconfig                      | 13 ++++++++++++
>  arch/powerpc/include/asm/Kbuild           |  2 ++
>  arch/powerpc/include/asm/qspinlock.h      | 25 +++++++++++++++++++++++
>  arch/powerpc/include/asm/spinlock.h       |  5 +++++
>  arch/powerpc/include/asm/spinlock_types.h |  5 +++++
>  arch/powerpc/lib/Makefile                 |  3 +++

>  include/asm-generic/qspinlock.h           |  2 ++

Who's ack do we need for that part?

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 24ac85c868db..17663ea57697 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -492,6 +494,17 @@ config HOTPLUG_CPU
>  
>  	  Say N if you are unsure.
>  
> +config PPC_QUEUED_SPINLOCKS
> +	bool "Queued spinlocks"
> +	depends on SMP
> +	default "y" if PPC_BOOK3S_64

Not sure about default y? At least until we've got a better idea of the
perf impact on a range of small/big new/old systems.

> +	help
> +	  Say Y here to use to use queued spinlocks which are more complex
> +	  but give better salability and fairness on large SMP and NUMA
> +	  systems.
> +
> +	  If unsure, say "Y" if you have lots of cores, otherwise "N".

Would be nice if we could give a range for "lots".

> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index dadbcf3a0b1e..1dd8b6adff5e 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -6,5 +6,7 @@ generated-y += syscall_table_spu.h
>  generic-y += export.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> +generic-y += qrwlock.h
> +generic-y += qspinlock.h

The 2nd line spits a warning about a redundant entry. I think you want
to just drop it.


cheers
