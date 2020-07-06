From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Mon, 6 Jul 2020 11:53:16 +0200
Message-ID: <cf10b0bc-de79-1b2b-8355-fc7bbeec47c3@csgroup.eu>
References: <20200706021822.1515189-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:56862 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJxX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 05:53:23 -0400
In-Reply-To: <20200706021822.1515189-1-npiggin@gmail.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-arch@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>



Le 06/07/2020 à 04:18, Nicholas Piggin a écrit :
> powerpc return from interrupt and return from system call sequences are
> context synchronising.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   .../features/sched/membarrier-sync-core/arch-support.txt      | 4 ++--
>   arch/powerpc/Kconfig                                          | 1 +
>   arch/powerpc/include/asm/exception-64s.h                      | 4 ++++
>   3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index 8a521a622966..52ad74a25f54 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -5,7 +5,7 @@
>   #
>   # Architecture requirements
>   #
> -# * arm/arm64
> +# * arm/arm64/powerpc
>   #
>   # Rely on implicit context synchronization as a result of exception return
>   # when returning from IPI handler, and when returning to user-space.
> @@ -45,7 +45,7 @@
>       |       nios2: | TODO |
>       |    openrisc: | TODO |
>       |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: |  ok  |
>       |       riscv: | TODO |
>       |        s390: | TODO |
>       |          sh: | TODO |
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 9fa23eb320ff..920c4e3ca4ef 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -131,6 +131,7 @@ config PPC
>   	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_MEMBARRIER_CALLBACKS
> +	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
>   	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 47bd4ea0837d..b88cb3a989b6 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -68,6 +68,10 @@
>    *
>    * The nop instructions allow us to insert one or more instructions to flush the
>    * L1-D cache when returning to userspace or a guest.
> + *
> + * powerpc relies on return from interrupt/syscall being context synchronising
> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SYNC_CORE
> + * without additional additional synchronisation instructions.

This file is dedicated to BOOK3S/64. What about other ones ?

On 32 bits, this is also valid as 'rfi' is also context synchronising, 
but then why just add some comment in exception-64s.h and only there ?

>    */
>   #define RFI_FLUSH_SLOT							\
>   	RFI_FLUSH_FIXUP_SECTION;					\
> 


Christophe
